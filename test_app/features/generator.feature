Feature: generating social_engine migrations
  In order to use social_engine
  A user should be able to
  generate migrations

  Scenario: run install generator
    Given a working directory
    And I delete existing social_engine migrations
    And I delete the static assets and yetting
    When I run the install generator
    Then a timestamped file named 'create_comments_table.rb' is created in the '/db/migrate/' directory
    And a timestamped file named 'create_ratings_table.rb' is created in the '/db/migrate/' directory
    And a timestamped file named 'create_votes_table.rb' is created in the '/db/migrate/' directory
    And a timestamped file named 'create_favorites_table.rb' is created in the '/db/migrate/' directory
    And a timestamped file named 'create_reputations_table.rb' is created in the '/db/migrate/' directory
    And a timestamped file named 'create_reputation_actions_table.rb' is created in the '/db/migrate/' directory        
    And a file named 'social_engine.yml' is created in the '/config/yettings/' directory
    And a file named 'social_engine.css' is created in the '/public/stylesheets/' directory
    And a file named 'formtastic.css' is created in the '/public/stylesheets/' directory    

  Scenario: run user rep generator
    Given a working directory
    When I run the user rep generator
    Then a timestamped file named 'add_reputation_to_users_table.rb' is created in the '/db/migrate/' directory

  Scenario: run migration files
    Given a working directory
    When I remove the user rep attribute
    And I remove the indexes
    And I run db migrate
    Then the migrations should run and create social_engine tables
    And the migrations should update the users table
    
