## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_TRACING_ENABLED<br/>STORAGE_SYSTEM_TRACING_ENABLED | bool | false | Activates tracing.|
| OCIS_TRACING_TYPE<br/>STORAGE_SYSTEM_TRACING_TYPE | string |  | The type of tracing. Defaults to "", which is the same as "jaeger". Allowed tracing types are "jaeger" and "" as of now.|
| OCIS_TRACING_ENDPOINT<br/>STORAGE_SYSTEM_TRACING_ENDPOINT | string |  | The endpoint of the tracing agent.|
| OCIS_TRACING_COLLECTOR<br/>STORAGE_SYSTEM_TRACING_COLLECTOR | string |  | The HTTP endpoint for sending spans directly to a collector, i.e. http://jaeger-collector:14268/api/traces. Only used if the tracing endpoint is unset.|
| OCIS_LOG_LEVEL<br/>STORAGE_SYSTEM_LOG_LEVEL | string |  | The log level. Valid values are: "panic", "fatal", "error", "warn", "info", "debug", "trace".|
| OCIS_LOG_PRETTY<br/>STORAGE_SYSTEM_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>STORAGE_SYSTEM_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>STORAGE_SYSTEM_LOG_FILE | string |  | The path to the log file. Activates logging to this file if set.|
| STORAGE_SYSTEM_DEBUG_ADDR | string | 127.0.0.1:9217 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| STORAGE_SYSTEM_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint|
| STORAGE_SYSTEM_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling|
| STORAGE_SYSTEM_DEBUG_ZPAGES | bool | false | Enables zpages, which can be used for collecting and viewing in-memory traces.|
| STORAGE_SYSTEM_GRPC_ADDR | string | 127.0.0.1:9215 | The bind address of the GRPC service.|
| STORAGE_SYSTEM_GRPC_PROTOCOL | string | tcp | The transport protocol of the GPRC service.|
| STORAGE_SYSTEM_HTTP_ADDR | string | 127.0.0.1:9216 | The bind address of the HTTP service.|
| STORAGE_SYSTEM_HTTP_PROTOCOL | string | tcp | The transport protocol of the HTTP service.|
| STORAGE_SYSTEM_EVENTS_ENDPOINT | string |  | The address of the streaming service.|
| STORAGE_SYSTEM_EVENTS_CLUSTER | string |  | The clusterID of the streaming service. Mandatory when using the NATS service.|
| OCIS_JWT_SECRET<br/>STORAGE_SYSTEM_JWT_SECRET | string |  | The secret to mint and validate jwt tokens.|
| REVA_GATEWAY | string | 127.0.0.1:9142 | The CS3 gateway endpoint.|
| OCIS_SYSTEM_USER_ID | string |  | ID of the oCIS storage-system system user. Admins need to set the ID for the STORAGE-SYSTEM system user in this config option which is then used to reference the user. Any reasonable long string is possible, preferably this would be an UUIDv4 format.|
| OCIS_SYSTEM_USER_API_KEY | string |  | API key for the STORAGE-SYSTEM system user.|
| STORAGE_SYSTEM_SKIP_USER_GROUPS_IN_TOKEN | bool | false | Disables the loading of user's group memberships from the reva access token.|
| STORAGE_SYSTEM_DRIVER | string | ocis | The driver which should be used by the service.|
| STORAGE_SYSTEM_OCIS_ROOT | string | ~/.ocis/storage/metadata | Path for the directory where the STORAGE-SYSTEM service stores it's persistent data.|
| STORAGE_SYSTEM_DATA_SERVER_URL | string | http://localhost:9216/data | URL of the data server, needs to be reachable by other services using this service.|