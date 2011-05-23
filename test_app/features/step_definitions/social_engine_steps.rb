require 'systemu'

MIGRATION_FILES = ["create_comments_table",
                   "create_votes_table",
                   "create_ratings_table",
                   "create_favorites_table",
                   "create_reputations_table",
                   "create_reputation_actions_table",
                   "create_friendings_table",
                   "add_reputation_to_users"]

Given 'a working directory' do
  @working_dir = File.dirname(__FILE__)+"/../../"
end

Then /^a timestamped file named '(.*)' is created in the '(.*)' directory$/ do |file,dir|
  full_dir = @working_dir+dir
  Dir.entries(full_dir).each do |timestamped_file|
    file = timestamped_file if timestamped_file.include? file
  end

  assert File.exists?(full_dir+file), "#{file} expected to exist, but did not"
  assert File.file?(full_dir+file), "#{file} expected to be a file, but is not"
end

Then /^a file named '(.*)' is created in the '(.*)' directory$/ do |file,dir|
  full_dir = @working_dir+dir
  assert File.exists?(full_dir+file), "#{file} expected to exist, but did not"
  assert File.file?(full_dir+file), "#{file} expected to be a file, but is not"
end

When /^I run the install generator$/ do
  @generator_output = systemu("rails g social_engine:install")
end

When /^I run the user rep generator$/ do
  @generator_output = systemu("rails g social_engine:user_reputation")[1]
end

When /^I remove the user rep attribute$/ do
  ActiveRecord::Migration.remove_column :users, :reputation rescue nil
end

When /^I remove the indexes$/ do
  ActiveRecord::Migration.remove_index :votes, :name=> :votes_index rescue nil
  ActiveRecord::Migration.remove_index :favorites, :name=> :favorites_index rescue nil
  ActiveRecord::Migration.remove_index :comments, :name=> :comments_index rescue nil
  ActiveRecord::Migration.remove_index :ratings, :name=> :ratings_index rescue nil
  ActiveRecord::Migration.remove_index :reputations, :reputation_action_id rescue nil
  ActiveRecord::Migration.remove_index :reputations, :name=> :user_reputation rescue nil
end


Given /^I delete existing social_engine migrations$/ do
  migrations_dir = "#{@working_dir}/db/migrate/"
  
  Dir.entries(migrations_dir).each do |file|
    MIGRATION_FILES.each do |mfile|
      File.delete("#{migrations_dir}/#{file}") if file.include? mfile
    end
  end
end

Given /^I delete the static assets and yetting$/ do
  FileUtils.rm_r("#{@working_dir}/config/yettings/") rescue nil
  FileUtils.rm("#{@working_dir}/public/stylesheets/formtastic.css") rescue nil
  FileUtils.rm_r("#{@working_dir}/public/stylesheets/social_engine.css") rescue nil    
end

When /^I run db migrate$/ do
  @migration_output = systemu("rake db:migrate RAILS_ENV=test")[1]
end

Then /^the migrations should run and create social_engine tables/ do
  assert @migration_output.include? "CreateRatingsTable: migrated"
  assert @migration_output.include? "CreateVotesTable: migrated"
  assert @migration_output.include? "CreateCommentsTable: migrated"
  assert @migration_output.include? "CreateFavoritesTable: migrated"
  assert @migration_output.include? "CreateReputationsTable: migrated"
  assert @migration_output.include? "CreateReputationActionsTable: migrated"
end

Then /^the migrations should update the users table/ do
  assert @migration_output.include?("AddReputationToUsersTable: migrated") and User.new.attributes.include?("reputation")
end

# mocks a logged in user by setting current_user
Given 'I am authenticated' do
  visit('/login')
end

Then /^I should see a "([^"]*)" widget$/ do |filename|
  filename.gsub!(" ","_")
  file = File.dirname(__FILE__)+"/../support/resources/#{filename}.html"
  page.body.should match /#{IO.read(file)}/
end

Then /^I should see html for "([^"]*)"$/ do |filename|
  filename.gsub!(" ","_")
  file = File.dirname(__FILE__)+"/../support/resources/#{filename}.html"  
  page.body.should match /#{IO.read(file)}/
end

Then /^I should see a button value of "([^"]*)"(?: within "([^"]*)")?$/ do |arg1,selector|
  with_scope(selector) do
    find_button(arg1).should_not eq nil
  end
end

Then /^there is a rep action for upvote and the article has a user$/ do
  Article.first.update_attributes(:user_id => 1)
  User.first.update_attributes(:reputation=>0)
  SocialEngineYetting.reputation["update_user_model"] = true
  ReputationAction.create(:name=>"upvote",:value=>2)
end

Then /^I set fingerprint method to "([^"]*)"$/ do |fmethod|
  SocialEngineYetting.class_eval("def self.fingerprint_method;'#{fmethod}';end;")
end

Then /^the user received rep$/ do
  User.first.reputation.should eq 2
end

Given /^I add some fake comments$/ do
  #TODO: remove hack to reset autoincrement so we can see proper value in div id... <div id='se-comment1'>
  ActiveRecord::Base.connection.execute "update sqlite_sequence set seq=0"
  
  first = Article.first.comments.create(unauthenticated_name:"john",unauthenticated_email:"john@couponshack.com",unauthenticated_website:"http://www.couponshack.com", comment: "test")
  first.created_at = "2011-04-13 17:39:00"
  first.save
  second = Article.first.comments.create(unauthenticated_name:"john2",unauthenticated_email:"john2@couponshack.com",unauthenticated_website:"http://www.couponshack.com", comment: "test2")
  second.created_at = "2011-04-13 17:39:00"
  second.save
end