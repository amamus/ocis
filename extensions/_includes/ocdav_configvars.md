## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_TRACING_ENABLED<br/>OCDAV_TRACING_ENABLED | bool | false | Activates tracing.|
| OCIS_TRACING_TYPE<br/>OCDAV_TRACING_TYPE | string |  | |
| OCIS_TRACING_ENDPOINT<br/>OCDAV_TRACING_ENDPOINT | string |  | The endpoint to the tracing collector.|
| OCIS_TRACING_COLLECTOR<br/>OCDAV_TRACING_COLLECTOR | string |  | |
| OCIS_LOG_LEVEL<br/>OCDAV_LOG_LEVEL | string |  | The log level.|
| OCIS_LOG_PRETTY<br/>OCDAV_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>OCDAV_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>OCDAV_LOG_FILE | string |  | The target log file.|
| OCDAV_DEBUG_ADDR | string | 127.0.0.1:9163 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| OCDAV_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint|
| OCDAV_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling|
| OCDAV_DEBUG_ZPAGES | bool | false | Enables zpages, which can  be used for collecting and viewing traces in-me|
| OCDAV_HTTP_ADDR | string | 127.0.0.1:0 | The address of the http service.|
| OCDAV_HTTP_PROTOCOL | string | tcp | The transport protocol of the http service.|
| OCDAV_HTTP_PREFIX | string |  | A URL path prefix for the handler.|
| OCIS_JWT_SECRET<br/>OCDAV_JWT_SECRET | string |  | |
| REVA_GATEWAY | string | 127.0.0.1:9142 | |
| OCDAV_SKIP_USER_GROUPS_IN_TOKEN | bool | false | |
| OCDAV_WEBDAV_NAMESPACE | string | /users/{{.Id.OpaqueId}} | Jail requests to /dav/webdav into this CS3 namespace. Supports template layouting with CS3 User properties.|
| OCDAV_FILES_NAMESPACE | string | /users/{{.Id.OpaqueId}} | Jail requests to /dav/files/{username} into this CS3 namespace. Supports template layouting with CS3 User properties.|
| OCDAV_SHARES_NAMESPACE | string | /Shares | The human readable path for the share jail. Relative to a users personal space root. Upcased intentionally.|
| OCIS_URL<br/>OCDAV_PUBLIC_URL | string | https://localhost:9200 | |
| OCIS_INSECURE<br/>OCDAV_INSECURE | bool | false | |
| OCDAV_GATEWAY_REQUEST_TIMEOUT | int64 | 84300 | |