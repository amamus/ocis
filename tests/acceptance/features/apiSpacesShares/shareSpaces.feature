@api @skipOnOcV10 @S8ad2bddf
Feature: Share spaces
  As the owner of a space
  I want to be able to add members to a space, and to remove access for them

  Note - this feature is run in CI with ACCOUNTS_HASH_DIFFICULTY set to the default for production
  See https://github.com/owncloud/ocis/issues/1542 and https://github.com/owncloud/ocis/pull/839

  Background:
    Given these users have been created with default attributes and without skeleton files:
      | username |
      | Alice    |
      | Brian    |
      | Bob      |
    And the administrator has given "Alice" the role "Space Admin" using the settings api
    And user "Alice" has created a space "share space" with the default quota using the GraphApi
    And using spaces DAV path


  @Tb228e97e
  Scenario Outline: A Space Admin can share a space to another user
    When user "Alice" shares a space "share space" to user "Brian" with role "<role>"
    Then the HTTP status code should be "200"
    And the OCS status code should be "200"
    And the OCS status message should be "OK"
    And the user "Brian" should have a space called "share space" with these key and value pairs:
      | key       | value       |
      | driveType | project     |
      | id        | %space_id%  |
      | name      | share space |
    Examples:
      | role    |
      | manager |
      | editor  |
      | viewer  |


  @T87c05059
  Scenario: A user can see who has been granted access
    When user "Alice" shares a space "share space" to user "Brian" with role "viewer"
    Then the user "Alice" should have a space called "share space" granted to user "Brian" with role "viewer"


  @T6729a0ef
  Scenario: A user can see that the group has been granted access
    Given group "sales" has been created
    When user "Alice" shares a space "share space" to group "sales" with role "viewer"
    Then the HTTP status code should be "200"
    And the OCS status code should be "200"
    And the user "Alice" should have a space called "share space" granted to group "sales" with role "viewer"
   

  @Td1ccb706
  Scenario: A user can see a file in a received shared space
    Given user "Alice" has uploaded a file inside space "share space" with content "Test" to "test.txt"
    And user "Alice" has created a folder "Folder Main" in space "share space"
    When user "Alice" shares a space "share space" to user "Brian" with role "viewer"
    Then for user "Brian" the space "share space" should contain these entries:
      | test.txt    |
      | Folder Main |


  @Tb473a98e
  Scenario: When a user unshares a space, the space becomes unavailable to the receiver
    Given user "Alice" has shared a space "share space" to user "Brian" with role "viewer"
    And the user "Brian" should have a space called "share space" with these key and value pairs:
      | key       | value       |
      | driveType | project     |
      | id        | %space_id%  |
      | name      | share space |
    When user "Alice" unshares a space "share space" to user "Brian"
    Then the HTTP status code should be "200"
    And the user "Brian" should not have a space called "share space"


  @Tf1705c04
  Scenario Outline: Owner of a space cannot see the space after removing his access to the space
    Given user "Alice" has shared a space "share space" to user "Brian" with role "manager"
    When user "<user>" unshares a space "share space" to user "Alice"
    Then the HTTP status code should be "200"
    And the user "Brian" should have a space called "share space" owned by "Alice" with these key and value pairs:
      | key       | value       |
      | driveType | project     |
      | id        | %space_id%  |
      | name      | share space |
    But the user "Alice" should not have a space called "share space"
    Examples:
      | user  |
      | Alice |
      | Brian |


  @T4ef0a956
  Scenario: A user can add another user to the space managers to enable him
    Given user "Alice" has uploaded a file inside space "share space" with content "Test" to "test.txt"
    When user "Alice" shares a space "share space" to user "Brian" with role "manager"
    Then the user "Brian" should have a space called "share space" granted to "Brian" with role "manager"
    When user "Brian" shares a space "share space" to user "Bob" with role "viewer"
    Then the user "Bob" should have a space called "share space" granted to "Bob" with role "viewer"
    And for user "Bob" the space "share space" should contain these entries:
      | test.txt |


  @Taa53292e
  Scenario Outline: A user cannot share a disabled space to another user
    Given user "Alice" has disabled a space "share space"
    When user "Alice" shares a space "share space" to user "Brian" with role "<role>"
    Then the HTTP status code should be "404"
    And the OCS status code should be "404"
    And the OCS status message should be "Wrong path, file/folder doesn't exist"
    And the user "Brian" should not have a space called "share space"
    Examples:
      | role    |
      | manager |
      | editor  |
      | viewer  |


  @Tc9da5f83
  Scenario Outline: A user with manager role can share a space to another user
    Given user "Alice" has shared a space "share space" to user "Brian" with role "manager"
    When user "Brian" shares a space "share space" to user "Bob" with role "<role>"
    Then the HTTP status code should be "200"
    And the OCS status code should be "200"
    And the OCS status message should be "OK"
    And the user "Bob" should have a space called "share space" with these key and value pairs:
      | key       | value       |
      | driveType | project     |
      | id        | %space_id%  |
      | name      | share space |
    Examples:
      | role    |
      | manager |
      | editor  |
      | viewer  |


  @T048c8249
  Scenario Outline: A user with editor or viewer role cannot share a space to another user
    Given user "Alice" has shared a space "share space" to user "Brian" with role "<role>"
    When user "Brian" shares a space "share space" to user "Bob" with role "<new_role>"
    Then the HTTP status code should be "404"
    And the OCS status code should be "404"
    And the OCS status message should be "No share permission"
    And the user "Bob" should not have a space called "share space"
    Examples:
      | role   | new_role |
      | editor | manager  |
      | editor | editor   |
      | editor | viewer   |
      | viewer | manager  |
      | viewer | editor   |
      | viewer | viewer   |


  @Tf0300d98
  Scenario Outline: space manager can change the role of space members
    Given user "Alice" has shared a space "share space" to user "Brian" with role "<role>"
    When user "Alice" updates the space "share space" for user "Brian" changing the role to "<new_role>"
    Then the HTTP status code should be "200"
    And the OCS status code should be "200"
    And the user "Alice" should have a space called "share space" granted to "Brian" with role "<new_role>"
    Examples:
      | role    | new_role |
      | editor  | manager  |
      | editor  | viewer   |
      | viewer  | manager  |
      | viewer  | editor   |
      | manager | editor   |
      | manager | viewer   |


  @T942bdbc3
  Scenario Outline: user without manager role cannot change the role of space members
    Given user "Alice" has shared a space "share space" to user "Brian" with role "<role>"
    And user "Alice" has shared a space "share space" to user "Bob" with role "viewer"
    When user "Brian" updates the space "share space" for user "Bob" changing the role to "<new_role>"
    Then the HTTP status code should be "404"
    And the OCS status code should be "404"
    And the user "Alice" should have a space called "share space" granted to "Bob" with role "viewer"
    Examples:
      | role   | new_role |
      | editor | manager  |
      | editor | viewer   |
      | viewer | manager  |
      | viewer | editor   |


  @Tc7c612f6
  Scenario Outline: A user shares a space with a group
    Given group "group2" has been created
    And the administrator has added a user "Brian" to the group "group2" using GraphApi
    And the administrator has added a user "Bob" to the group "group2" using GraphApi
    When user "Alice" shares a space "share space" to group "group2" with role "<role>"
    Then the HTTP status code should be "200"
    And the user "Brian" should have a space called "share space" with these key and value pairs:
      | key       | value       |
      | driveType | project     |
      | name      | share space |
    And the user "Bob" should have a space called "share space" with these key and value pairs:
      | key       | value       |
      | driveType | project     |
      | name      | share space |
    Examples:
      | role    |
      | manager |
      | editor  |
      | viewer  |


  @T05a72bea
  Scenario Outline: The user has no access to the space if access for the group has been removed
    Given group "group2" has been created
    And the administrator has added a user "Brian" to the group "group2" using GraphApi
    And user "Alice" has shared a space "share space" to group "group2" with role "<role>"
    When user "Alice" unshares a space "share space" to group "group2"
    Then the HTTP status code should be "200"
    And the user "Brian" should not have a space called "share space"
    Examples:
      | role    |
      | manager |
      | editor  |
      | viewer  |


  @T74b9de34
  Scenario: The user has no access to the space if he has been removed from the group
    Given group "group2" has been created
    And the administrator has added a user "Brian" to the group "group2" using GraphApi
    And the administrator has added a user "Bob" to the group "group2" using GraphApi
    And user "Alice" has shared a space "share space" to group "group2" with role "editor"
    When the administrator removes the following users from the following groups using the Graph API
      | username | groupname |
      | Brian    | group2    |
    Then the HTTP status code of responses on all endpoints should be "204"
    And the user "Brian" should not have a space called "share space"
    But the user "Bob" should have a space called "share space" with these key and value pairs:
      | key       | value       |
      | driveType | project     |
      | name      | share space |


  @T3b83991a
  Scenario: Users don't have access to the space if the group has been deleted
    Given group "group2" has been created
    And the administrator has added a user "Brian" to the group "group2" using GraphApi
    And the administrator has added a user "Bob" to the group "group2" using GraphApi
    And user "Alice" has shared a space "share space" to group "group2" with role "editor"
    When the administrator deletes group "group2" using the Graph API
    Then the HTTP status code should be "204"
    And the user "Brian" should not have a space called "share space"
    And the user "Bob" should not have a space called "share space"


  @Tf2ee6499
  Scenario Outline: User increases permissions for one member of the group or for the entire group
    Given group "sales" has been created
    And the administrator has added a user "Brian" to the group "sales" using GraphApi
    And user "Alice" has shared a space "share space" to <firstRecipient> with role "viewer"
    When user "Brian" uploads a file inside space "share space" with content "Test" to "test.txt" using the WebDAV API
    Then the HTTP status code should be "403"
    When user "Alice" shares a space "share space" to <secondRecipient> with role "editor"
    Then the HTTP status code should be "200"
    When user "Brian" uploads a file inside space "share space" with content "Test" to "test.txt" using the WebDAV API
    Then the HTTP status code should be "201"
    Examples:
      | firstRecipient | secondRecipient |
      | group "sales"  | user "Brian"    |
      | user "Brian"   | group "sales"   |
