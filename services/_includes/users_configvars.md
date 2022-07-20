## Environment Variables

| Name | Type | Default Value | Description |
|------|------|---------------|-------------|
| OCIS_TRACING_ENABLED<br/>USERS_TRACING_ENABLED | bool | false | Activates tracing.|
| OCIS_TRACING_TYPE<br/>USERS_TRACING_TYPE | string |  | The type of tracing. Defaults to "", which is the same as "jaeger". Allowed tracing types are "jaeger" and "" as of now.|
| OCIS_TRACING_ENDPOINT<br/>USERS_TRACING_ENDPOINT | string |  | The endpoint of the tracing agent.|
| OCIS_TRACING_COLLECTOR<br/>USERS_TRACING_COLLECTOR | string |  | The HTTP endpoint for sending spans directly to a collector, i.e. http://jaeger-collector:14268/api/traces. Only used if the tracing endpoint is unset.|
| OCIS_LOG_LEVEL<br/>USERS_LOG_LEVEL | string |  | The log level. Valid values are: "panic", "fatal", "error", "warn", "info", "debug", "trace".|
| OCIS_LOG_PRETTY<br/>USERS_LOG_PRETTY | bool | false | Activates pretty log output.|
| OCIS_LOG_COLOR<br/>USERS_LOG_COLOR | bool | false | Activates colorized log output.|
| OCIS_LOG_FILE<br/>USERS_LOG_FILE | string |  | The path to the log file. Activates logging to this file if set.|
| USERS_DEBUG_ADDR | string | 127.0.0.1:9145 | Bind address of the debug server, where metrics, health, config and debug endpoints will be exposed.|
| USERS_DEBUG_TOKEN | string |  | Token to secure the metrics endpoint.|
| USERS_DEBUG_PPROF | bool | false | Enables pprof, which can be used for profiling.|
| USERS_DEBUG_ZPAGES | bool | false | Enables zpages, which can be used for collecting and viewing in-memory traces.|
| USERS_GRPC_ADDR | string | 127.0.0.1:9144 | The bind address of the GRPC service.|
| USERS_GRPC_PROTOCOL | string | tcp | The transport protocol of the GPRC service.|
| OCIS_JWT_SECRET<br/>USERS_JWT_SECRET | string |  | The secret to mint and validate jwt tokens.|
| REVA_GATEWAY | string | 127.0.0.1:9142 | The CS3 gateway endpoint.|
| USERS_SKIP_USER_GROUPS_IN_TOKEN | bool | false | Disables the loading of user's group memberships from the reva access token.|
| USERS_DRIVER | string | ldap | The user driver which should be used by the users service. Supported values are 'ldap', 'owncloudsql', 'json' and 'rest'.|
| LDAP_URI<br/>USERS_LDAP_URI | string | ldaps://localhost:9235 | URI of the LDAP Server to connect to. Supported URI schemes are 'ldaps://' and 'ldap://'|
| LDAP_CACERT<br/>USERS_LDAP_CACERT | string | ~/.ocis/idm/ldap.crt | Path to a CA certificate file for validating the LDAP server's TLS certificate. If empty the system default CA bundle will be used.|
| LDAP_INSECURE<br/>USERS_LDAP_INSECURE | bool | false | Disable TLS certificate validation for the LDAP connections. Do not set this in production environments.|
| LDAP_BIND_DN<br/>USERS_LDAP_BIND_DN | string | uid=reva,ou=sysusers,o=libregraph-idm | LDAP DN to use for simple bind authentication with the target LDAP server.|
| LDAP_BIND_PASSWORD<br/>USERS_LDAP_BIND_PASSWORD | string |  | Password to use for authenticating the 'bind_dn'.|
| LDAP_USER_BASE_DN<br/>USERS_LDAP_USER_BASE_DN | string | ou=users,o=libregraph-idm | Search base DN for looking up LDAP users.|
| LDAP_GROUP_BASE_DN<br/>USERS_LDAP_GROUP_BASE_DN | string | ou=groups,o=libregraph-idm | Search base DN for looking up LDAP groups.|
| LDAP_USER_SCOPE<br/>USERS_LDAP_USER_SCOPE | string | sub | LDAP search scope to use when looking up users. Supported values are 'base', 'one' and 'sub'.|
| LDAP_GROUP_SCOPE<br/>USERS_LDAP_GROUP_SCOPE | string | sub | LDAP search scope to use when looking up groups. Supported values are 'base', 'one' and 'sub'.|
| LDAP_USER_FILTER<br/>USERS_LDAP_USER_FILTER | string |  | LDAP filter to add to the default filters for user search like '(objectclass=ownCloud)'.|
| LDAP_GROUP_FILTER<br/>USERS_LDAP_GROUP_FILTER | string |  | LDAP filter to add to the default filters for group searches.|
| LDAP_USER_OBJECTCLASS<br/>USERS_LDAP_USER_OBJECTCLASS | string | inetOrgPerson | The object class to use for users in the default user search filter like 'inetOrgPerson'.|
| LDAP_GROUP_OBJECTCLASS<br/>USERS_LDAP_GROUP_OBJECTCLASS | string | groupOfNames | The object class to use for groups in the default group search filter like 'groupOfNames'. |
| OCIS_URL<br/>OCIS_OIDC_ISSUER<br/>USERS_IDP_URL | string | https://localhost:9200 | The identity provider value to set in the userids of the CS3 user objects for users returned by this user provider.|
| LDAP_USER_SCHEMA_ID<br/>USERS_LDAP_USER_SCHEMA_ID | string | ownclouduuid | LDAP Attribute to use as the unique id for users. This should be a stable globally unique id like a UUID.|
| LDAP_USER_SCHEMA_ID_IS_OCTETSTRING<br/>USERS_LDAP_USER_SCHEMA_ID_IS_OCTETSTRING | bool | false | Set this to true if the defined 'id' attribute for users is of the 'OCTETSTRING' syntax. This is e.g. required when using the 'objectGUID' attribute of Active Directory for the user ID's.|
| LDAP_USER_SCHEMA_MAIL<br/>USERS_LDAP_USER_SCHEMA_MAIL | string | mail | LDAP Attribute to use for the email address of users.|
| LDAP_USER_SCHEMA_DISPLAYNAME<br/>USERS_LDAP_USER_SCHEMA_DISPLAYNAME | string | displayname | LDAP Attribute to use for the displayname of users.|
| LDAP_USER_SCHEMA_USERNAME<br/>USERS_LDAP_USER_SCHEMA_USERNAME | string | uid | LDAP Attribute to use for username of users.|
| LDAP_GROUP_SCHEMA_ID<br/>USERS_LDAP_GROUP_SCHEMA_ID | string | ownclouduuid | LDAP Attribute to use as the unique ID for groups. This should be a stable globally unique ID like a UUID.|
| LDAP_GROUP_SCHEMA_ID_IS_OCTETSTRING<br/>USERS_LDAP_GROUP_SCHEMA_ID_IS_OCTETSTRING | bool | false | Set this to true if the defined 'id' attribute for groups is of the 'OCTETSTRING' syntax. This is e.g. required when using the 'objectGUID' attribute of Active Directory for the group ID's.|
| LDAP_GROUP_SCHEMA_MAIL<br/>USERS_LDAP_GROUP_SCHEMA_MAIL | string | mail | LDAP Attribute to use for the email address of groups (can be empty).|
| LDAP_GROUP_SCHEMA_DISPLAYNAME<br/>USERS_LDAP_GROUP_SCHEMA_DISPLAYNAME | string | cn | LDAP Attribute to use for the displayname of groups (often the same as groupname attribute).|
| LDAP_GROUP_SCHEMA_GROUPNAME<br/>USERS_LDAP_GROUP_SCHEMA_GROUPNAME | string | cn | LDAP Attribute to use for the name of groups.|
| LDAP_GROUP_SCHEMA_MEMBER<br/>USERS_LDAP_GROUP_SCHEMA_MEMBER | string | member | LDAP Attribute that is used for group members.|
| USERS_OWNCLOUDSQL_DB_USERNAME | string | owncloud | Database user to use for authenticating with the owncloud database.|
| USERS_OWNCLOUDSQL_DB_PASSWORD | string | secret | Password for the database user.|
| USERS_OWNCLOUDSQL_DB_HOST | string | mysql | Hostname of the database server.|
| USERS_OWNCLOUDSQL_DB_PORT | int | 3306 | Network port to use for the database connection.|
| USERS_OWNCLOUDSQL_DB_NAME | string | owncloud | Name of the owncloud database.|
| USERS_OWNCLOUDSQL_IDP | string | https://localhost:9200 | The identity provider value to set in the userids of the CS3 user objects for users returned by this user provider.|
| USERS_OWNCLOUDSQL_NOBODY | int64 | 90 | Fallback number if no numeric UID and GID properties are provided.|
| USERS_OWNCLOUDSQL_JOIN_USERNAME | bool | false | Join the user properties table to read usernames|
| USERS_OWNCLOUDSQL_JOIN_OWNCLOUD_UUID | bool | false | Join the user properties table to read user IDs.|
| USERS_OWNCLOUDSQL_ENABLE_MEDIAL_SEARCH | bool | false | Allow 'medial search' when searching for users instead of just doing a prefix search. This allows finding 'Alice' when searching for 'lic'.|