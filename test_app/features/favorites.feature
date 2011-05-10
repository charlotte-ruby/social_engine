Feature: Favorites and Favoritable objects
  In order to use favorites
  A user should be able to
  add make an article one of their favorites

  Scenario: An anonymous user can't favorite an article
    Given I am on the first article page
    Then I should not see "Add to your favorites"

  Scenario: An authenticated user can favorite and unfavorite an article using defaults
    Given I am on the first article page
    And I click "Login"
    Then I should see a button value of "Add to favorites" within "#default-favorites-widget"
    And I press "Add to favorites" within "#default-favorites-widget"
    Then I should see a button value of "Remove from favorites" within "#default-favorites-widget"
    And I press "Remove from favorites" within "#default-favorites-widget"
    Then I should see a button value of "Add to favorites" within "#default-favorites-widget"
    
  Scenario: An authenticated user can favorite and unfavorite an article using custom widget
    Given I am on the first article page
    And I click "Login"
    Then I should see a button value of "Like" within "#custom-favorites-widget"
    And I press "Like" within "#custom-favorites-widget"
    Then I should see a button value of "Unlike" within "#custom-favorites-widget"
    And I press "Unlike" within "#custom-favorites-widget"
    Then I should see a button value of "Like" within "#custom-favorites-widget"