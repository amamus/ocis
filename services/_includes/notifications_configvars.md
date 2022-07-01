## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_LOG_LEVEL<br/>NOTIFICATIONS_LOG_LEVEL | string |  | The log level. Valid values are: "panic", "fatal", "error", "warn", "info", "debug", "trace".|
| OCIS_LOG_PRETTY<br/>NOTIFICATIONS_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>NOTIFICATIONS_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>NOTIFICATIONS_LOG_FILE | string |  | The path to the log file. Activates logging to this file if set.|
| NOTIFICATIONS_DEBUG_ADDR | string | 127.0.0.1:9174 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| NOTIFICATIONS_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint|
| NOTIFICATIONS_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling|
| NOTIFICATIONS_DEBUG_ZPAGES | bool | false | Enables zpages, which can be used for collecting and viewing in-memory traces.|
| NOTIFICATIONS_SMTP_HOST | string | 127.0.0.1 | SMTP host, to connect to.|
| NOTIFICATIONS_SMTP_PORT | string | 1025 | Port of the SMTP host, to connect to.|
| NOTIFICATIONS_SMTP_SENDER | string | noreply@example.com | Sender of emails, that will be sent.|
| NOTIFICATIONS_SMTP_PASSWORD | string |  | Password of the SMTP host, to connect to.|
| NOTIFICATIONS_EVENTS_ENDPOINT | string | 127.0.0.1:9233 | Endpoint of the event system.|
| NOTIFICATIONS_EVENTS_CLUSTER | string | ocis-cluster | Cluster ID of the event system.|
| NOTIFICATIONS_EVENTS_GROUP | string | notifications | Name of the event group / queue on the event system.|
| REVA_GATEWAY<br/>NOTIFICATIONS_REVA_GATEWAY | string | 127.0.0.1:9142 | CS3 gateway used to look up user metadata|
| OCIS_MACHINE_AUTH_API_KEY<br/>NOTIFICATIONS_MACHINE_AUTH_API_KEY | string |  | Machine auth API key used for accessing the 'auth-machine' service to look up their email.|