package config

import "github.com/owncloud/ocis/v2/ocis-pkg/shared"

// HTTP defines the available http configuration.
type HTTP struct {
	Addr      string                `yaml:"addr" env:"STATIC_FILE_SERVER_HTTP_ADDR" desc:"The bind address of the HTTP service."`
	TLS       shared.HTTPServiceTLS `yaml:"tls"`
	Namespace string                `yaml:"-"`
	Root      string                `yaml:"root" env:"STATIC_FILE_SERVER_HTTP_ROOT" desc:"Subdirectory that serves as the root for this HTTP service."`
	CacheTTL  int                   `yaml:"cache_ttl" env:"STATIC_FILE_SERVER_CACHE_TTL" desc:"Cache policy in seconds for static assets."`
}
