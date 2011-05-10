require "social_engine"
require "rails"

module SocialEngine
  class Engine < Rails::Engine
    initializer 'social_engine.ar_extensions', :before=>"action_controller.deprecated_routes" do |app|
      ActiveRecord::Base.extend SocialEngine::Voteable
      ActiveRecord::Base.extend SocialEngine::Commentable
      ActiveRecord::Base.extend SocialEngine::Rateable
      ActiveRecord::Base.extend SocialEngine::Favoriteable
      ActiveRecord::Base.extend SocialEngine::Reputatable
      ActiveRecord::Base.extend SocialEngine::Sociable
      ActiveRecord::Base.extend SocialEngine::SocialUser      
    end
    
    initializer 'social_engine.controller' do |app|
      ActiveSupport.on_load(:action_controller) do
         include SocialEngineController
      end
    end
    
    config.to_prepare do
      ActionView::Base.send(:include, SocialEngineHelper)
      SocialEngine::Engine.add_poly_belongs_to
    end
    
    #TODO:refactor
    #add polymorhpic_belongs_to to inherited_resources controllers after detecting which models use 'able' functions
    def self.add_poly_belongs_to
      [CommentsController,RatingsController,VotesController,FavoritesController].each do |controller|
        poly_belongs_tos = []
        Dir.glob("#{Rails.root.to_s}/app/models/**/*.rb").each do |model_name|
          #TODO: gotta be a better way to do this.  REFACTOR!
          model_name = model_name.split("/").last.gsub(".rb","")
          klass = model_name.camelize.constantize rescue next
          able_id = controller.to_s.gsub("sController","").gsub("ing","e").downcase+"able?"
          poly_belongs_tos << model_name.to_sym if klass.instance_methods.include?(able_id.to_sym)
        end
        controller.class_eval("polymorphic_belongs_to :#{poly_belongs_tos.join(',:')}") unless poly_belongs_tos.blank?
      end
    end
  end
end