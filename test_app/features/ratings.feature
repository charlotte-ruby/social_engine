Feature: Ratings and Rateable objects
  In order to use ratings
  A user should be able to
  create ratings and view ratings for ratewable objects

  Scenario: A user can create a new rating with defaults
    Given I am on the first article page
    And I choose "rating_value_3" within "#default-rating-form"
    And I press "Rate" within "#default-rating-form"
    And I should see "3.0" within "#rating-area"
    And I should see "1" within "#rating-area"

  Scenario: A user can create a new rating with custom max val
    Given I am on the first article page
    And I choose "rating_value_7" within "#custom-rating-form"
    And I press "Rate" within "#custom-rating-form"
    And I should see "7.0" within "#rating-area"
    And I should see "1" within "#rating-area"
    
  Scenario: A user with the same IP can't rate twice
    Given I am on the first article page
    And I set fingerprint method to "ip_address"    
    And I choose "rating_value_7" within "#custom-rating-form"
    And I press "Rate" within "#custom-rating-form"
    And I should see "7.0" within "#rating-area"
    And I should see "1" within "#rating-area"
    And I choose "rating_value_6" within "#custom-rating-form"
    And I press "Rate" within "#custom-rating-form"
    Then I should see "7.0" within "#rating-area"
    And I should see "1" within "#rating-area"
    
  Scenario: A User with same IP can rate twice if fingerprint method set to :none
    Given I am on the first article page
    And I set fingerprint method to "none"
    And I choose "rating_value_7" within "#custom-rating-form"
    And I press "Rate" within "#custom-rating-form"
    And I should see "7.0" within "#rating-area"
    And I should see "1" within "#rating-area"
    And I choose "rating_value_6" within "#custom-rating-form"
    And I press "Rate" within "#custom-rating-form"
    Then I should see "6.5" within "#rating-area"
    And I should see "2" within "#rating-area"