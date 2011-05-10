require 'rails/generators'
require 'rails/generators/migration'     

module SocialEngine
  class UserReputationGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.join(File.dirname(__FILE__), 'templates')

    def self.next_migration_number(dirname)
      sleep 1
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end

    def create_migration_file
      migration_template 'add_reputation_to_users_table.rb', 'db/migrate/add_reputation_to_users_table.rb'  
    end
  end
end