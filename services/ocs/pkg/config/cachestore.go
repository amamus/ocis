package config

// CacheStore defines the available configuration for the cache store
type CacheStore struct {
	Type    string `yaml:"type" env:"OCIS_CACHE_STORE_TYPE;OCS_CACHE_STORE_TYPE" desc:"The type of the cache store. Valid options are \"noop\", \"ocmem\", \"etcd\" and \"memory\""`
	Address string `yaml:"address" env:"OCIS_CACHE_STORE_ADDRESS;OCS_CACHE_STORE_ADDRESS" desc:"a comma-separated list of addresses to connect to. Only for etcd"`
	Size    int    `yaml:"size" env:"OCIS_CACHE_STORE_SIZE;OCS_CACHE_STORE_SIZE" desc:"Maximum size for the cache store. Only ocmem will use this option, in number of items per table. The rest will ignore the option and can grow indefinitely"`
}