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
| STORAGE_SYSTEM_GRPC_ADDR | string | 127.0.0.1:9215 | The address of the grpc service.|
| STORAGE_SYSTEM_GRPC_PROTOCOL | string | tcp | The transport protocol of the grpc service.|
| STORAGE_SYSTEM_HTTP_ADDR | string | 127.0.0.1:9216 | The address of the http service.|
| STORAGE_SYSTEM_HTTP_PROTOCOL | string | tcp | The transport protocol of the http service.|
| STORAGE_SYSTEM_EVENTS_ENDPOINT | string |  | the address of the streaming service|
| STORAGE_SYSTEM_EVENTS_CLUSTER | string |  | the clusterID of the streaming service. Mandatory when using nats|
| OCIS_JWT_SECRET<br/>STORAGE_SYSTEM_JWT_SECRET | string |  | The secret to mint and validate jwt tokens.|
| REVA_GATEWAY | string | 127.0.0.1:9142 | The CS3 gateway endpoint.|
| OCIS_SYSTEM_USER_ID | string |  | |
| OCIS_SYSTEM_USER_API_KEY | string |  | |
| STORAGE_SYSTEM_SKIP_USER_GROUPS_IN_TOKEN | bool | false | |
| STORAGE_SYSTEM_DRIVER | string | ocis | The driver which should be used by the service|
| STORAGE_SYSTEM_OCIS_ROOT | string | ~/.ocis/storage/metadata | |
| STORAGE_SYSTEM_DATA_SERVER_URL | string | http://localhost:9216/data | |
| STORAGE_SYSTEM_TEMP_FOLDER | string | ~/.ocis/tmp/metadata | |
| OCIS_INSECURE<br/>STORAGE_SYSTEM_DATAPROVIDER_INSECURE | bool | false | |