module SocialEngine
  module Favoriteable
    def is_favoriteable
      has_many :favorites, :as=>:favoriteable, :dependent => :destroy
      include InstanceMethods
    end
    
    module InstanceMethods
      def favoriteable?
        true
      end
    end
  end
end