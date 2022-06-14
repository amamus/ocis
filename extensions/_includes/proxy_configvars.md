## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_TRACING_ENABLED<br/>PROXY_TRACING_ENABLED | bool | false | |
| OCIS_TRACING_TYPE<br/>PROXY_TRACING_TYPE | string |  | |
| OCIS_TRACING_ENDPOINT<br/>PROXY_TRACING_ENDPOINT | string |  | |
| OCIS_TRACING_COLLECTOR<br/>PROXY_TRACING_COLLECTOR | string |  | |
| OCIS_LOG_LEVEL<br/>PROXY_LOG_LEVEL | string |  | |
| OCIS_LOG_PRETTY<br/>PROXY_LOG_PRETTY | bool | false | |
| OCIS_LOG_COLOR<br/>PROXY_LOG_COLOR | bool | false | |
| OCIS_LOG_FILE<br/>PROXY_LOG_FILE | string |  | |
| PROXY_DEBUG_ADDR | string | 127.0.0.1:9205 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| PROXY_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint|
| PROXY_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling|
| PROXY_DEBUG_ZPAGES | bool | false | Enables zpages, which can  be used for collecting and viewing traces in-me|
| PROXY_HTTP_ADDR | string | 0.0.0.0:9200 | |
| PROXY_HTTP_ROOT | string | / | |
| PROXY_TRANSPORT_TLS_CERT | string | ~/.ocis/proxy/server.crt | |
| PROXY_TRANSPORT_TLS_KEY | string | ~/.ocis/proxy/server.key | |
| PROXY_TLS | bool | true | |
| REVA_GATEWAY | string | 127.0.0.1:9142 | |
| OCIS_URL<br/>OCIS_OIDC_ISSUER<br/>PROXY_OIDC_ISSUER | string | https://localhost:9200 | URL of the OpenID connect identity provider.|
| OCIS_INSECURE<br/>PROXY_OIDC_INSECURE | bool | true | Disable TLS certificate validation for connections to the IDP. (not recommended for production environments.|
| PROXY_OIDC_USERINFO_CACHE_SIZE | int | 1024 | |
| PROXY_OIDC_USERINFO_CACHE_TTL | int | 10 | |
| OCIS_JWT_SECRET<br/>PROXY_JWT_SECRET | string |  | |
| PROXY_ENABLE_PRESIGNEDURLS | bool | true | |
| PROXY_ACCOUNT_BACKEND_TYPE | string | cs3 | Account backend the proxy should use, currenly only 'cs3' is possible here.|
| PROXY_USER_OIDC_CLAIM | string | email | The name of an OpenID Connect claim that should be used for resolving users with the account backend. Currently defaults to 'email'.|
| PROXY_USER_CS3_CLAIM | string | mail | The name of a CS3 user attribute (claim) that should be mapped to the 'user_oidc_claim'. Currently defaults to 'mail' (other possible values are: 'username', 'displayname')|
| OCIS_MACHINE_AUTH_API_KEY<br/>PROXY_MACHINE_AUTH_API_KEY | string |  | |
| PROXY_AUTOPROVISION_ACCOUNTS | bool | false | Set this to 'true' to automatically provsion users that do not yet exist in the users service on-demand upon first signin. To use this a write-enabled libregraph user backend needs to be setup an running.|
| PROXY_ENABLE_BASIC_AUTH | bool | false | Set this to true to enable 'basic' (username/password) authentication. (Default: false)|
| PROXY_INSECURE_BACKENDS | bool | false | Disable TLS certificate validation for all http backend connections. (Default: false)|