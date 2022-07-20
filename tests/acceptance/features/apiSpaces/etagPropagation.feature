@api
Feature: check etag propagation after different file alterations

  Scenario: copying a file inside a folder as a share receiver changes its etag for all collaborators
    Given user "Alice" has been created with default attributes and without skeleton files
    And user "Brian" has been created with default attributes and without skeleton files
    And using spaces DAV path
    And user "Alice" has created folder "/upload"
    And user "Alice" has uploaded file with content "uploaded content" to "/upload/file.txt"
    And user "Alice" has shared folder "/upload" with user "Brian"
    And user "Brian" has accepted share "/upload" offered by user "Alice"
    And user "Alice" has stored etag of element "/" inside space "Personal"
    And user "Alice" has stored etag of element "/upload" inside space "Personal"
    And user "Alice" has stored etag of element "/upload/file.txt" inside space "Personal"
    And user "Alice" has stored etag of element "/upload/file.txt" on path "/upload/renamed.txt" inside space "Personal"
    And user "Brian" has stored etag of element "/" inside space "Shares Jail"
    And user "Brian" has stored etag of element "/upload" inside space "Shares Jail"
    And user "Brian" has stored etag of element "/upload/file.txt" inside space "Shares Jail"
    And user "Brian" has stored etag of element "upload/file.txt" on path "/upload/renamed.txt" inside space "Shares Jail"
    When user "Brian" copies file "/upload/file.txt" to "/upload/renamed.txt" inside space "Shares Jail" using the WebDAV API
    Then the HTTP status code should be "201"
    And these etags should have changed
      | user  | path                | space       |
      | Alice | /                   | Personal    |
      | Alice | /upload             | Personal    |
      | Alice | /upload/renamed.txt | Personal    |
      | Brian | /                   | Shares Jail |
      | Brian | /upload             | Shares Jail |
      | Brian | /upload/renamed.txt | Shares Jail |
    And these etags should not have changed
      | user  | path             | space       |
      | Alice | /upload/file.txt | Personal    |
      | Brian | /upload/file.txt | Shares Jail |

  Scenario: copying a file inside a folder as a sharer changes its etag for all collaborators
    Given user "Alice" has been created with default attributes and without skeleton files
    Given user "Brian" has been created with default attributes and without skeleton files
    And using spaces DAV path
    And user "Alice" has created folder "/upload"
    And user "Alice" has uploaded file with content "uploaded content" to "/upload/file.txt"
    And user "Alice" has shared folder "/upload" with user "Brian"
    And user "Brian" has accepted share "/upload" offered by user "Alice"
    And user "Alice" has stored etag of element "/" inside space "Personal"
    And user "Alice" has stored etag of element "/upload" inside space "Personal"
    And user "Alice" has stored etag of element "/upload/file.txt" inside space "Personal"
    And user "Alice" has stored etag of element "/upload/file.txt" on path "/upload/renamed.txt" inside space "Personal"
    And user "Brian" has stored etag of element "/" inside space "Shares Jail"
    And user "Brian" has stored etag of element "/upload" inside space "Shares Jail"
    And user "Brian" has stored etag of element "/upload/file.txt" inside space "Shares Jail"
    And user "Brian" has stored etag of element "/upload/file.txt" on path "/upload/renamed.txt" inside space "Shares Jail"
    When user "Alice" copies file "/upload/file.txt" to "/upload/renamed.txt" using the WebDAV API
    Then the HTTP status code should be "201"
    And these etags should have changed
      | user  | path                | space       |
      | Alice | /                   | Personal    |
      | Alice | /upload             | Personal    |
      | Alice | /upload/renamed.txt | Personal    |
      | Brian | /                   | Shares Jail |
      | Brian | /upload             | Shares Jail |
      | Brian | /upload/renamed.txt | Shares Jail |
    And these etags should not have changed
      | user  | path             | space       |
      | Alice | /upload/file.txt | Personal    |
      | Brian | /upload/file.txt | Shares Jail |
