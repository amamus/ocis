## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_TRACING_ENABLED<br/>OCDAV_TRACING_ENABLED | bool | false | Activates tracing.|
| OCIS_TRACING_TYPE<br/>OCDAV_TRACING_TYPE | string |  | The type of tracing. Defaults to "", which is the same as "jaeger". Allowed tracing types are "jaeger" and "" as of now.|
| OCIS_TRACING_ENDPOINT<br/>OCDAV_TRACING_ENDPOINT | string |  | The endpoint of the tracing agent.|
| OCIS_TRACING_COLLECTOR<br/>OCDAV_TRACING_COLLECTOR | string |  | The HTTP endpoint for sending spans directly to a collector, i.e. http://jaeger-collector:14268/api/traces. Only used if the tracing endpoint is unset.|
| OCIS_LOG_LEVEL<br/>OCDAV_LOG_LEVEL | string |  | The log level. Valid values are: "panic", "fatal", "error", "warn", "info", "debug", "trace".|
| OCIS_LOG_PRETTY<br/>OCDAV_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>OCDAV_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>OCDAV_LOG_FILE | string |  | The path to the log file. Activates logging to this file if set.|
| OCDAV_DEBUG_ADDR | string | 127.0.0.1:9163 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| OCDAV_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint.|
| OCDAV_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling.|
| OCDAV_DEBUG_ZPAGES | bool | false | Enables zpages, which can be used for collecting and viewing in-memory traces.|
| OCDAV_HTTP_ADDR | string | 127.0.0.1:0 | The bind address of the HTTP service.|
| OCDAV_HTTP_PROTOCOL | string | tcp | The transport protocol of the HTTP service.|
| OCDAV_HTTP_PREFIX | string |  | A URL path prefix for the handler.|
| OCIS_JWT_SECRET<br/>OCDAV_JWT_SECRET | string |  | The secret to mint and validate jwt tokens.|
| REVA_GATEWAY | string | 127.0.0.1:9142 | The CS3 gateway endpoint.|
| OCDAV_SKIP_USER_GROUPS_IN_TOKEN | bool | false | Disables the loading of user's group memberships from the reva access token.|
| OCDAV_WEBDAV_NAMESPACE | string | /users/{{.Id.OpaqueId}} | Jail requests to /dav/webdav into this CS3 namespace. Supports template layouting with CS3 User properties.|
| OCDAV_FILES_NAMESPACE | string | /users/{{.Id.OpaqueId}} | Jail requests to /dav/files/{username} into this CS3 namespace. Supports template layouting with CS3 User properties.|
| OCDAV_SHARES_NAMESPACE | string | /Shares | The human readable path for the share jail. Relative to a users personal space root. Upcased intentionally.|
| OCIS_URL<br/>OCDAV_PUBLIC_URL | string | https://localhost:9200 | URL where oCIS is reachable for users.|
| OCIS_INSECURE<br/>OCDAV_INSECURE | bool | false | Allow insecure connections to the GATEWAY service.|
| OCDAV_GATEWAY_REQUEST_TIMEOUT | int64 | 84300 | Request timeout in seconds for requests from the oCDAV service to the GATEWAY service.|
| OCIS_MACHINE_AUTH_API_KEY<br/>OCDAV_MACHINE_AUTH_API_KEY | string |  | Machine auth API key used to validate internal requests necessary for the access to resources from other services.|