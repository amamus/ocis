package http

import (
	"fmt"

	"github.com/owncloud/ocis/v2/ocis-pkg/service/http"
	"github.com/owncloud/ocis/v2/ocis-pkg/version"
	"go-micro.dev/v4"

	// webmid "github.com/owncloud/ocis/v2/services/static/pkg/middleware"
	svc "github.com/owncloud/ocis/v2/services/static-file-server/pkg/service/v0"
)

// Server initializes the http service and server.
func Server(opts ...Option) (http.Service, error) {
	options := newOptions(opts...)

	service, err := http.NewService(
		http.TLSConfig(options.Config.HTTP.TLS),
		http.Logger(options.Logger),
		http.Namespace(options.Namespace),
		http.Name(options.ServiceName),
		http.Version(version.GetString()),
		http.Address(options.Config.HTTP.Addr),
		http.Context(options.Context),
		http.Flags(options.Flags...),
	)
	if err != nil {
		return http.Service{}, fmt.Errorf("could not initialize http service: %w", err)
	}

	handle := svc.New(
	// 	svc.Logger(options.Logger),
	// 	svc.Config(options.Config),
	// 	svc.Middleware(
	// 		chimiddleware.RealIP,
	// 		chimiddleware.RequestID,
	// 		middleware.NoCache,
	// 		middleware.Secure,
	// 		// webmid.SilentRefresh,
	// 		middleware.Version(
	// 			"web",
	// 			version.GetString(),
	// 		),
	// 		middleware.Logger(
	// 			options.Logger,
	// 		),
	// 	),
	)
	//
	// {
	// 	handle = svc.NewInstrument(handle, options.Metrics)
	// 	handle = svc.NewLogging(handle, options.Logger)
	// 	handle = svc.NewTracing(handle)
	// }
	//
	if err := micro.RegisterHandler(service.Server(), handle); err != nil {
		return http.Service{}, err
	}

	return service, nil
}
