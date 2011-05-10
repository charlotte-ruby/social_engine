Feature: Third party buttons and widgets
  In order to use third party buttons and widgets
  A user should be able to
  add them to my views using helper methods
  
  Scenario: Tweetme button
    Given I am on the tweetme page
    Then I should see a "default tweetme" widget
    And I should see a "custom tweetme" widget

  Scenario: FB Like Button
    Given I am on the facebook like button page
    Then I should see a "default fblike" widget
    And I should see a "custom fblike" widget
    
  Scenario: FB Friend Box
    Given I am on the facebook friend box page
    Then I should see a "default fb friend box" widget
    And I should see a "custom fb friend box" widget
    
  Scenario: FB og tags
    Given I am on the facebook like button page
    Then I should see html for "default fb og tags"
    And I should see html for "custom fb og tags"
    
  Scenario: FB javascript SDK
    Given I am on the facebook like button page
    Then I should see html for "fb javascript sdk"