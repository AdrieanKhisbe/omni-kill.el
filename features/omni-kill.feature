Feature: Kill all the things
  In order to do make quick edits
  As a emacs user
  I want to do be able to quickly grab, kill, what under point

  Scenario: Basic Killing
    Given I switch to buffer "*omni-kill*"
     And I clear the buffer
     And I insert:
      """
      Word on Line 1
      Line 2

      New paragraph
      """
      And I go to the beginning of the buffer

  Scenario: Kill a word
    When I call "omni-kill-word"
    Then I should see:
      """
      on Line 1
      Line 2

      New paragraph
      """

  Scenario: Kill a line
    When  I call "omni-kill-line"
    Then I should see:
      """
      Line 2

      New paragraph
      """

  Scenario: Copy a line
    When  I call "omni-copy-line"
    And I press "C-y"
    Then I should see:
      """
      Line 2
      Line 2

      New paragraph
      """

  Scenario: Fail to delete a email
    When  I call "omni-delete-email"
    Then I should see:
      """
      Line 2
      Line 2

      New paragraph
      """
    And I should see message "There is not a email at point!"

  Scenario: Succeed to copy a word after deleting a word
    When I go to the beginning of the buffer
    And I call "omni-delete-word"
    And I call "omni-delete-whitespace"
    And I call "omni-copy-word"
    And I press "C-y"
    Then I should see:
      """
      22
      Line 2

      New paragraph
      """
  Scenario: Moving around
    When I call "omni-end-page"
    Then the cursor should be after "paragrap"
    When I call "omni-start-word"
    Then the cursor should be before "paragraph"
    And  the cursor should be after "New "

# §TODO: some for copy, delete

  Scenario: Get some help
    When I call "omni-kill-help"
    Then I should see message "Letter2Thing: d:defun e:email f:filename l:line L:list P:page p:sentence S:sexp s:symbol u:url W:whitespace w:word"
