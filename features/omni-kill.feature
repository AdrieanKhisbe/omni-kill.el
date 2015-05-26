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

  Scenario: Fail to delete a number
    When  I call "omni-delete-number"
    Then I should see:
      """
      Line 2
      Line 2

      New paragraph
      """
    And I should see message "There is not a number at point!"

  Scenario: Succeed to copy a number after deleting a word
    When I call "omni-delete-word"
    And I call "omni-delete-whitespace"
    And I call "omni-copy-number"
    And I press "C-y"
    Then I should see:
      """
      22
      Line 2

      New paragraph
      """
    And I should see message "There is not a number at point!"

# §TODO: some for copy, delete
