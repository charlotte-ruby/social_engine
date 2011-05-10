Feature: Votes and Voteable objects
  In order to use voting
  A user should be able to
  create votes and view vote counts for voteable objects

  Scenario: An anonymous user can create an upvote for an article
    Given I am on the first article page
    And I press "Upvote" within "#default-vote-widget"
    Then I should see "1" within "#default-vote-widget .se-vote-score"

  Scenario: An anonymous user can create a downvote for an article
    Given I am on the first article page
    And I press "Downvote" within "#default-vote-widget"
    Then I should see "-1" within "#default-vote-widget .se-vote-score"

  Scenario: An anonymous user can create a custom upvote an article
    Given I am on the first article page
    And I press "MoveUp" within "#custom-vote-widget"
    Then I should see "1" within "#custom-vote-widget .se-vote-score"

  Scenario: An anonymous user can create a custom downvote an article
    Given I am on the first article page
    And I press "MoveDown" within "#custom-vote-widget"
    Then I should see "-1" within "#custom-vote-widget .se-vote-score"
    
  Scenario: A user is not allowed to rate the same article twice based on their ip
    Given I am on the first article page
    And I set fingerprint method to "ip_address"    
    And I press "Upvote" within "#default-vote-widget"
    Then I should see "1" within "#default-vote-widget .se-vote-score"
    And I press "Upvote" within "#default-vote-widget"
    Then I should see "1" within "#default-vote-widget .se-vote-score"
    
  Scenario: A user is allowed to rate the same article twice if fingerprint method set to :none
    Given I am on the first article page
    And I set fingerprint method to "none"
    And I press "Upvote" within "#default-vote-widget"
    Then I should see "1" within "#default-vote-widget .se-vote-score"
    And I press "Upvote" within "#default-vote-widget"
    Then I should see "2" within "#default-vote-widget .se-vote-score"