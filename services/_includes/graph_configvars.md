## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_TRACING_ENABLED<br/>GRAPH_TRACING_ENABLED | bool | false | Activates tracing.|
| OCIS_TRACING_TYPE<br/>GRAPH_TRACING_TYPE | string |  | The type of tracing. Defaults to "", which is the same as "jaeger". Allowed tracing types are "jaeger" and "" as of now.|
| OCIS_TRACING_ENDPOINT<br/>GRAPH_TRACING_ENDPOINT | string |  | The endpoint of the tracing agent.|
| OCIS_TRACING_COLLECTOR<br/>GRAPH_TRACING_COLLECTOR | string |  | The HTTP endpoint for sending spans directly to a collector, i.e. http://jaeger-collector:14268/api/traces. Only used if the tracing endpoint is unset.|
| OCIS_LOG_LEVEL<br/>GRAPH_LOG_LEVEL | string |  | The log level. Valid values are: "panic", "fatal", "error", "warn", "info", "debug", "trace".|
| OCIS_LOG_PRETTY<br/>GRAPH_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>GRAPH_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>GRAPH_LOG_FILE | string |  | The path to the log file. Activates logging to this file if set.|
| GRAPH_DEBUG_ADDR | string | 127.0.0.1:9124 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| GRAPH_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint.|
| GRAPH_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling.|
| GRAPH_DEBUG_ZPAGES | bool | false | Enables zpages, which can be used for collecting and viewing in-memory traces.|
| GRAPH_HTTP_ADDR | string | 127.0.0.1:9120 | The bind address of the HTTP service.|
| GRAPH_HTTP_ROOT | string | /graph | Subdirectory that serves as the root for this HTTP service.|
| REVA_GATEWAY | string | 127.0.0.1:9142 | The CS3 gateway endpoint.|
| OCIS_JWT_SECRET<br/>GRAPH_JWT_SECRET | string |  | The secret to mint and validate jwt tokens.|
| OCIS_URL<br/>GRAPH_SPACES_WEBDAV_BASE | string | https://localhost:9200 | The public facing URL of WebDAV.|
| GRAPH_SPACES_WEBDAV_PATH | string | /dav/spaces/ | The WebDAV subpath for spaces.|
| GRAPH_SPACES_DEFAULT_QUOTA | string | 1000000000 | The default quota in bytes.|
| GRAPH_SPACES_EXTENDED_SPACE_PROPERTIES_CACHE_TTL | int | 0 | Max TTL in seconds for the spaces property cache.|
| GRAPH_IDENTITY_BACKEND | string | ldap | The user identity backend to use. Supported backend types are 'ldap' and 'cs3'.|
| LDAP_URI<br/>GRAPH_LDAP_URI | string | ldaps://localhost:9235 | URI of the LDAP Server to connect to. Supported URI schemes are 'ldaps://' and 'ldap://'|
| LDAP_CACERT<br/>GRAPH_LDAP_CACERT | string | ~/.ocis/idm/ldap.crt | The certificate to verify TLS connections.|
| LDAP_INSECURE<br/>GRAPH_LDAP_INSECURE | bool | false | Disable TLS certificate validation for the LDAP connections. Do not set this in production environments.|
| LDAP_BIND_DN<br/>GRAPH_LDAP_BIND_DN | string | uid=libregraph,ou=sysusers,o=libregraph-idm | LDAP DN to use for simple bind authentication with the target LDAP server.|
| LDAP_BIND_PASSWORD<br/>GRAPH_LDAP_BIND_PASSWORD | string |  | Password to use for authenticating the 'bind_dn'.|
| GRAPH_LDAP_SERVER_UUID | bool | false | If set to true, rely on the LDAP Server to generate a unique ID for users and groups, like when using 'entryUUID' as the user ID attribute.|
| GRAPH_LDAP_SERVER_USE_PASSWORD_MODIFY_EXOP | bool | true | User the Password Modify Extended Operation for updating user passwords.|
| GRAPH_LDAP_SERVER_WRITE_ENABLED | bool | true | Allow to create, modify and delete LDAP users via GRAPH API. This is only works when the default Schema is used.|
| LDAP_USER_BASE_DN<br/>GRAPH_LDAP_USER_BASE_DN | string | ou=users,o=libregraph-idm | Search base DN for looking up LDAP users.|
| LDAP_USER_SCOPE<br/>GRAPH_LDAP_USER_SCOPE | string | sub | LDAP search scope to use when looking up users. Supported scopes are 'base', 'one' and 'sub'.|
| LDAP_USER_FILTER<br/>GRAPH_LDAP_USER_FILTER | string |  | LDAP filter to add to the default filters for user search like '(objectclass=ownCloud)'.|
| LDAP_USER_OBJECTCLASS<br/>GRAPH_LDAP_USER_OBJECTCLASS | string | inetOrgPerson | The object class to use for users in the default user search filter ('inetOrgPerson').|
| LDAP_USER_SCHEMA_MAIL<br/>GRAPH_LDAP_USER_EMAIL_ATTRIBUTE | string | mail | LDAP Attribute to use for the email address of users.|
| LDAP_USER_SCHEMA_DISPLAY_NAME<br/>GRAPH_LDAP_USER_DISPLAYNAME_ATTRIBUTE | string | displayName | LDAP Attribute to use for the displayname of users.|
| LDAP_USER_SCHEMA_USERNAME<br/>GRAPH_LDAP_USER_NAME_ATTRIBUTE | string | uid | LDAP Attribute to use for username of users.|
| LDAP_USER_SCHEMA_ID<br/>GRAPH_LDAP_USER_UID_ATTRIBUTE | string | owncloudUUID | LDAP Attribute to use as the unique ID for users. This should be a stable globally unique ID like a UUID.|
| LDAP_GROUP_BASE_DN<br/>GRAPH_LDAP_GROUP_BASE_DN | string | ou=groups,o=libregraph-idm | Search base DN for looking up LDAP groups.|
| LDAP_GROUP_SCOPE<br/>GRAPH_LDAP_GROUP_SEARCH_SCOPE | string | sub | LDAP search scope to use when looking up groups. Supported scopes are 'base', 'one' and 'sub'.|
| LDAP_GROUP_FILTER<br/>GRAPH_LDAP_GROUP_FILTER | string |  | LDAP filter to add to the default filters for group searches.|
| LDAP_GROUP_OBJECTCLASS<br/>GRAPH_LDAP_GROUP_OBJECTCLASS | string | groupOfNames | The object class to use for groups in the default group search filter ('groupOfNames'). |
| LDAP_GROUP_SCHEMA_GROUPNAME<br/>GRAPH_LDAP_GROUP_NAME_ATTRIBUTE | string | cn | LDAP Attribute to use for the name of groups.|
| LDAP_GROUP_SCHEMA_ID<br/>GRAPH_LDAP_GROUP_ID_ATTRIBUTE | string | owncloudUUID | LDAP Attribute to use as the unique id for groups. This should be a stable globally unique ID like a UUID.|
| GRAPH_EVENTS_ENDPOINT | string | 127.0.0.1:9233 | The address of the event system. The event system is the message queuing service. It is used as message broker for the microservice architecture. Set to a empty string to disable emitting events.|
| GRAPH_EVENTS_CLUSTER | string | ocis-cluster | The clusterID of the event system. The event system is the message queuing service. It is used as message broker for the microservice architecture.|