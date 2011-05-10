SOCIAL_ENGINE_PATH = File.dirname(__FILE__) + "/social_engine"
require "#{SOCIAL_ENGINE_PATH}/core_ext/array.rb"
require "#{SOCIAL_ENGINE_PATH}/core_ext/hash.rb"
require "#{SOCIAL_ENGINE_PATH}/engine.rb"
require "inherited_resources"
require "haml"
require "formtastic"
require "yettings"

module SocialEngine
end