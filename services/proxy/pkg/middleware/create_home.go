package middleware

import (
	"net/http"

	gateway "github.com/cs3org/go-cs3apis/cs3/gateway/v1beta1"
	rpc "github.com/cs3org/go-cs3apis/cs3/rpc/v1beta1"
	provider "github.com/cs3org/go-cs3apis/cs3/storage/provider/v1beta1"
	revactx "github.com/cs3org/reva/v2/pkg/ctx"
	"github.com/cs3org/reva/v2/pkg/rgrpc/status"
	"github.com/cs3org/reva/v2/pkg/utils"
	"github.com/owncloud/ocis/v2/ocis-pkg/log"
	"google.golang.org/grpc/metadata"
)

// CreateHome provides a middleware which sends a CreateHome request to the reva gateway
func CreateHome(optionSetters ...Option) func(next http.Handler) http.Handler {
	options := newOptions(optionSetters...)
	logger := options.Logger

	return func(next http.Handler) http.Handler {
		return &createHome{
			next:              next,
			logger:            logger,
			revaGatewayClient: options.RevaGatewayClient,
		}
	}
}

type createHome struct {
	next              http.Handler
	logger            log.Logger
	revaGatewayClient gateway.GatewayAPIClient
	defaultQuota      string
}

func (m createHome) ServeHTTP(w http.ResponseWriter, req *http.Request) {
	if !m.shouldServe(req) {
		m.next.ServeHTTP(w, req)
		return
	}

	token := req.Header.Get("x-access-token")

	// we need to pass the token to authenticate the CreateHome request.
	//ctx := tokenpkg.ContextSetToken(r.Context(), token)
	ctx := metadata.AppendToOutgoingContext(req.Context(), revactx.TokenHeader, token)

	getHomeReq := &provider.ListStorageSpacesRequest{
		Filters: []*provider.ListStorageSpacesRequest_Filter{
			{
				Type: provider.ListStorageSpacesRequest_Filter_TYPE_SPACE_TYPE,
				Term: &provider.ListStorageSpacesRequest_Filter_SpaceType{
					SpaceType: "personal",
				},
			},
		},
	}

	getHomeResp, err := m.revaGatewayClient.ListStorageSpaces(ctx, getHomeReq)
	if err != nil || getHomeResp.Status.Code != rpc.Code_CODE_OK {
		m.next.ServeHTTP(w, req)
		return
	}

	if len(getHomeResp.StorageSpaces) != 0 {
		m.next.ServeHTTP(w, req)
		return
	}

	createHomeReq := &provider.CreateHomeRequest{}
	if m.defaultQuota != "" {
		createHomeReq.Opaque = utils.AppendPlainToOpaque(nil, "quota", m.defaultQuota)
	}
	createHomeRes, err := m.revaGatewayClient.CreateHome(ctx, createHomeReq)
	if err != nil {
		m.logger.Err(err).Msg("error calling CreateHome")
	} else if createHomeRes.Status.Code != rpc.Code_CODE_OK {
		err := status.NewErrorFromCode(createHomeRes.Status.Code, "gateway")
		if createHomeRes.Status.Code != rpc.Code_CODE_ALREADY_EXISTS {
			m.logger.Err(err).Msg("error when calling Createhome")
		}
	}

	m.next.ServeHTTP(w, req)
}

func (m createHome) shouldServe(req *http.Request) bool {
	return req.Header.Get("x-access-token") != ""
}
