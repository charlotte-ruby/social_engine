Feature: Comments and Commentable objects
  In order to use comments
  A user should be able to
  create comments and view comments for commentable objects

  Scenario: An anonymous user can create a new comment
    Given I am on the first article page
    And I fill in "Name" with "John Anon" within "#new_comment"
    And I fill in "Email" with "john@couponshack.com" within "#new_comment"
    And I fill in "Website" with "http://www.couponshack.com" within "#new_comment"
    And I fill in "Comment" with "These are some comments" within "#new_comment"
    And I press "Add Comment"
    Then I should see "These are some comments"
    And I should see "John Anon"

  Scenario: An authenticated user can create a new comment
    Given I am on the first article page
    And I am authenticated
    Then I should not see "Name" within "#new_comment"
    And I should not see "Email" within "#new_comment"
    And I should not see "Website" within "#new_comment"
    And I fill in "Comment" with "Authenticated comments" within "#new_comment"
    And I press "Add Comment"
    Then I should see "Authenticated comments"
    And I should see "John McAliley"

  Scenario: comments form should show defaults if no options specified
    Given I am on the comments test form page
    Then I should see "Name" within "#first_form"
    And I should see "Email" within "#first_form"
    And I should see "Website" within "#first_form"
    
  Scenario: comments form should not show name if it is not included in the options
    Given I am on the comments test form page
    And I should not see "Name" within "#second_form"
    And I should see "Email" within "#second_form"
    And I should see "Website" within "#second_form"
    
  Scenario: comments form should not show name and email if not specified in the options
    Given I am on the comments test form page
    And I should not see "Name" within "#third_form"
    And I should not see "Email" within "#third_form"
    And I should see "Website" within "#third_form"
    
  Scenario: comments form should show no user fields if options are blank {}
    Given I am on the comments test form page
    And I should see "Name" within "#fourth_form"
    And I should see "Email" within "#fourth_form"
    And I should see "Website" within "#fourth_form"
    
  Scenario: Default comment list
    Given I add some fake comments
    Given I am on the comments list page
    Then I should see html for "default comment list"
    And I should see html for "custom comment list"