package service

import (
	"context"
	"errors"
	"fmt"
	revactx "github.com/cs3org/reva/v2/pkg/ctx"
	"github.com/cs3org/reva/v2/pkg/errtypes"
	"github.com/cs3org/reva/v2/pkg/events/server"
	"github.com/cs3org/reva/v2/pkg/rgrpc/todo/pool"
	"github.com/go-micro/plugins/v4/events/natsjs"
	"github.com/owncloud/ocis/v2/services/search/pkg/content"
	"github.com/owncloud/ocis/v2/services/search/pkg/engine"
	"github.com/owncloud/ocis/v2/services/search/pkg/search"
	merrors "go-micro.dev/v4/errors"
	"go-micro.dev/v4/metadata"
	grpcmetadata "google.golang.org/grpc/metadata"

	"github.com/owncloud/ocis/v2/ocis-pkg/log"
	searchsvc "github.com/owncloud/ocis/v2/protogen/gen/ocis/services/search/v0"
)

// NewHandler returns a service implementation for Service.
func NewHandler(opts ...Option) (searchsvc.SearchProviderHandler, func(), error) {
	teardown := func() {}
	options := newOptions(opts...)
	logger := options.Logger
	cfg := options.Config

	// initialize search engine
	var eng engine.Engine
	switch cfg.Engine.Type {
	case "bleve":
		idx, err := engine.NewBleveIndex(cfg.Engine.Bleve.Datapath)
		if err != nil {
			return nil, teardown, err
		}

		teardown = func() {
			_ = idx.Close()
		}

		eng = engine.NewBleveEngine(idx)
	default:
		return nil, teardown, fmt.Errorf("unknown search engine: %s", cfg.Engine.Type)
	}

	// initialize gateway
	gw, err := pool.GetGatewayServiceClient(cfg.Reva.Address)
	if err != nil {
		logger.Fatal().Err(err).Str("addr", cfg.Reva.Address).Msg("could not get reva client")
		return nil, teardown, err
	}
	// initialize search content extractor
	var extractor content.Extractor
	switch cfg.Extractor.Type {
	case "basic":
		if extractor, err = content.NewBasicExtractor(logger); err != nil {
			return nil, teardown, err
		}
	case "tika":
		if extractor, err = content.NewTikaExtractor(gw, logger, cfg); err != nil {
			return nil, teardown, err
		}
	default:
		return nil, teardown, fmt.Errorf("unknown search extractor: %s", cfg.Extractor.Type)
	}

	// initialize nats
	bus, err := server.NewNatsStream(
		natsjs.Address(cfg.Events.Endpoint),
		natsjs.ClusterID(cfg.Events.Cluster),
	)
	if err != nil {
		return nil, teardown, err
	}

	// setup event handling
	if err := search.HandleEvents(eng, extractor, gw, bus, logger, cfg); err != nil {
		return nil, teardown, err
	}

	return &Service{
		id:       cfg.GRPC.Namespace + "." + cfg.Service.Name,
		log:      logger,
		provider: search.NewProvider(gw, eng, extractor, logger, cfg.MachineAuthAPIKey),
	}, teardown, nil
}

// Service implements the searchServiceHandler interface
type Service struct {
	id       string
	log      log.Logger
	provider *search.Provider
}

func (s Service) Search(ctx context.Context, in *searchsvc.SearchRequest, out *searchsvc.SearchResponse) error {
	// Get token from the context (go-micro) and make it known to the reva client too (grpc)
	t, ok := metadata.Get(ctx, revactx.TokenHeader)
	if !ok {
		s.log.Error().Msg("Could not get token from context")
		return errors.New("could not get token from context")
	}
	ctx = grpcmetadata.AppendToOutgoingContext(ctx, revactx.TokenHeader, t)

	res, err := s.provider.Search(ctx, &searchsvc.SearchRequest{
		Query:    in.Query,
		PageSize: in.PageSize,
	})
	if err != nil {
		switch err.(type) {
		case errtypes.BadRequest:
			return merrors.BadRequest(s.id, err.Error())
		default:
			return merrors.InternalServerError(s.id, err.Error())
		}
	}

	out.Matches = res.Matches
	out.TotalMatches = res.TotalMatches
	out.NextPageToken = res.NextPageToken
	return nil
}

// IndexSpace (re)indexes all resources of a given space.
func (s Service) IndexSpace(ctx context.Context, in *searchsvc.IndexSpaceRequest, _ *searchsvc.IndexSpaceResponse) error {
	_, err := s.provider.IndexSpace(ctx, in)
	return err
}