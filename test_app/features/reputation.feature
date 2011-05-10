Feature: User Reputation
  In order to have reputation
  A user should be able to
  do things that give them a reputation

  Scenario: A user gets reputation if they upvote an article
    Given I am on the first article page
    And there is a rep action for upvote and the article has a user
    And I press "Upvote" within "#default-vote-widget"
    Then the user received rep
    