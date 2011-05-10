Feature: Reputation actions
  In order to use reputation action
  An admin should be able to 
  create, edit and destroy reputation actions

  Scenario: A user can create & edit a reputation action
    Given I am on the reputation actions page
    And I click "Add New Reputation Action"
    Then I should be on the new reputation action page
    And I fill in "Name" with "Vote Up"
    And I fill in "Value" with "2"
    And I fill in "Description" with "User Votes up a question"
    And I press "Save"
    Then I should be on the reputation actions page
    And I should see "Vote Up"
    And I should see "2"
    And I click "Edit"
    And I fill in "Name" with "Vote Up Changed"
    And I fill in "Value" with "789"
    And I fill in "Description" with "User Votes up a question changed"
    And I press "Save"
    Then I should be on the reputation actions page
    And I should see "Vote Up Changed"
    And I should see "789"
    
    
    
    
