class ReputationAction < ActiveRecord::Base
  has_many :reputations, :dependent=>:destroy
  
  def self.list_from_rails_source
    list = []
    files = Dir.glob("{#{Rails.root.to_s},#{SocialEngine::Engine.root.to_s}}/app/{controllers,models}/**/*.rb")
    files.each do |file|
      source = IO.read(file)
      source.scan(/(Reputation.add|add_able_rep)\(("|')(.*)("|'),.*\)/).each do |line|
        list << line[2] if line[2].present?
      end
    end
    list
  end
end