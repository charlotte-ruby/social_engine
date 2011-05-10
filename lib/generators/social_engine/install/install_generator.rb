require 'rails/generators'
require 'rails/generators/migration'     

module SocialEngine
  class InstallGenerator < Rails::Generators::Base
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
      migration_template 'create_comments_table.rb', 'db/migrate/create_comments_table.rb'
      migration_template 'create_votes_table.rb', 'db/migrate/create_votes_table.rb'
      migration_template 'create_ratings_table.rb', 'db/migrate/create_ratings_table.rb'
      migration_template 'create_favorites_table.rb', 'db/migrate/create_favorites_table.rb'
      migration_template 'create_reputations_table.rb', 'db/migrate/create_reputations_table.rb'
      migration_template 'create_reputation_actions_table.rb', 'db/migrate/create_reputation_actions_table.rb'    
    end
  
    def create_static_assets
      copy_file "social_engine_yetting.yml", "config/yettings/social_engine.yml"
      copy_file "social_engine.css", "public/stylesheets/social_engine.css"    
      copy_file "formtastic.css", "public/stylesheets/formtastic.css"
    end
  end
end