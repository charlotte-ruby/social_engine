module SocialEngine
  module Sociable
    def is_sociable
      is_rateable
      is_voteable
      is_commentable
      is_favoriteable
      include InstanceMethods
    end
    
    module InstanceMethods
      def sociable?
        true
      end
    end
  end
end