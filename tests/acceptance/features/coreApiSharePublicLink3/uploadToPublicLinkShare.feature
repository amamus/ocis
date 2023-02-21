@api @files_sharing-app-required @public_link_share-feature-required @issue-ocis-reva-315 @issue-ocis-reva-316 @issue-ocis-2079 @S63848a19

Feature: upload to a public link share

  Background:
    Given user "Alice" has been created with default attributes and without skeleton files
    And user "Alice" has created folder "FOLDER"

  @smokeTest @issue-ocis-reva-286 @T60eac4ef
  Scenario: Uploading same file to a public upload-only share multiple times via new API
    # The new API does the autorename automatically in upload-only folders
    Given user "Alice" has created a public link share with settings
      | path        | FOLDER |
      | permissions | create |
    When the public uploads file "test.txt" with content "test" using the new public WebDAV API
    And the public uploads file "test.txt" with content "test2" using the new public WebDAV API
    Then the HTTP status code of responses on all endpoints should be "201"
    And the following headers should match these regular expressions
      | ETag | /^"[a-f0-9:\.]{1,32}"$/ |
    And the content of file "/FOLDER/test.txt" for user "Alice" should be "test"
    And the content of file "/FOLDER/test (2).txt" for user "Alice" should be "test2"


  @Tf1e3a1d3
  Scenario Outline: Uploading file to a public upload-only share using public API that was deleted does not work
    Given using <dav-path> DAV path
    And user "Alice" has created a public link share with settings
      | path        | FOLDER |
      | permissions | create |
    And user "Alice" has deleted folder "/FOLDER"
    When the public uploads file "test.txt" with content "test" using the new public WebDAV API
    And the HTTP status code should be "404"

    @issue-ocis-reva-290
    Examples:
      | dav-path |
      | old      |
      | new      |

    @personalSpace
    Examples:
      | dav-path |
      | spaces   |

  @issue-reva-292 @T35a4beb6
  Scenario: Uploading file to a public read-only share folder with public API does not work
    Given user "Alice" has created a public link share with settings
      | path        | FOLDER |
      | permissions | read   |
    When the public uploads file "test.txt" with content "test" using the new public WebDAV API
    And the HTTP status code should be "403"


  @T32ce9696
  Scenario: Uploading to a public upload-only share with public API
    Given user "Alice" has created a public link share with settings
      | path        | FOLDER |
      | permissions | create |
    When the public uploads file "test.txt" with content "test-file" using the new public WebDAV API
    Then the HTTP status code should be "201"
    And the content of file "/FOLDER/test.txt" for user "Alice" should be "test-file"
    And the following headers should match these regular expressions
      | ETag | /^"[a-f0-9:\.]{1,32}"$/ |


  @T47a1afaf
  Scenario: Uploading to a public upload-only share with password with public API
    Given user "Alice" has created a public link share with settings
      | path        | FOLDER   |
      | password    | %public% |
      | permissions | create   |
    When the public uploads file "test.txt" with password "%public%" and content "test-file" using the new public WebDAV API
    Then the HTTP status code should be "201"
    And the content of file "/FOLDER/test.txt" for user "Alice" should be "test-file"


  @T208dfcd4
  Scenario: Uploading to a public read/write share with password with public API
    Given user "Alice" has created a public link share with settings
      | path        | FOLDER   |
      | password    | %public% |
      | permissions | change   |
    When the public uploads file "test.txt" with password "%public%" and content "test-file" using the new public WebDAV API
    Then the HTTP status code should be "201"
    And the content of file "/FOLDER/test.txt" for user "Alice" should be "test-file"


  @Ta583bfc4
  Scenario: Uploading file to a public shared folder with read/write permission when the sharer has insufficient quota does not work with public API
    When user "Alice" creates a public link share using the sharing API with settings
      | path        | FOLDER |
      | permissions | change |
    And the quota of user "Alice" has been set to "0"
    When the public uploads file "test.txt" with content "test-file" using the new public WebDAV API
    Then the HTTP status code should be "507"

  @issue-reva-195 @Tb0d98337
  Scenario: Uploading file to a public shared folder with upload-only permission when the sharer has insufficient quota does not work with public API
    When user "Alice" creates a public link share using the sharing API with settings
      | path        | FOLDER |
      | permissions | create |
    And the quota of user "Alice" has been set to "0"
    When the public uploads file "test.txt" with content "test-file" using the new public WebDAV API
    Then the HTTP status code should be "507"

  @issue-reva-41 @T0486d25f
  Scenario: Uploading file to a public shared folder does not work when allow public uploads has been disabled before sharing and again enabled after sharing the folder with public API
    Given parameter "shareapi_allow_public_upload" of app "core" has been set to "no"
    And user "Alice" has created a public link share with settings
      | path | FOLDER |
    And parameter "shareapi_allow_public_upload" of app "core" has been set to "yes"
    When the public uploads file "test.txt" with content "test-file" using the new public WebDAV API
    And the HTTP status code should be "403"

  @issue-reva-41 @T9f7a80b3
  Scenario: Uploading file to a public shared folder works when allow public uploads has been disabled and again enabled after sharing the folder with public API
    Given user "Alice" has created a public link share with settings
      | path        | FOLDER |
      | permissions | create |
    And parameter "shareapi_allow_public_upload" of app "core" has been set to "no"
    And parameter "shareapi_allow_public_upload" of app "core" has been set to "yes"
    When the public uploads file "test.txt" with content "test-file" using the new public WebDAV API
    Then the HTTP status code should be "201"
    And the content of file "/FOLDER/test.txt" for user "Alice" should be "test-file"

  @smokeTest @T8368e44a
  Scenario: Uploading to a public upload-write and no edit and no overwrite share with public API
    Given user "Alice" has created a public link share with settings
      | path        | FOLDER          |
      | permissions | uploadwriteonly |
    When the public uploads file "test.txt" with content "test-file" using the new public WebDAV API
    Then the HTTP status code should be "201"
    And the content of file "/FOLDER/test.txt" for user "Alice" should be "test-file"

  @smokeTest @issue-reva-286 @T92f59c78
  Scenario: Uploading same file to a public upload-write and no edit and no overwrite share multiple times with new public API
    Given user "Alice" has created a public link share with settings
      | path        | FOLDER          |
      | permissions | uploadwriteonly |
    When the public uploads file "test.txt" with content "test" using the new public WebDAV API
    Then the HTTP status code should be "201"
    And the following headers should match these regular expressions
      | ETag | /^"[a-f0-9:\.]{1,32}"$/ |
    When the public uploads file "test.txt" with content "test2" using the new public WebDAV API
    Then the HTTP status code should be "201"
    And the content of file "/FOLDER/test.txt" for user "Alice" should be "test"
    And the content of file "/FOLDER/test (2).txt" for user "Alice" should be "test2"
