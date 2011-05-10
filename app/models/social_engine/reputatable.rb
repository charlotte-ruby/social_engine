module SocialEngine
  module Reputatable
    def has_reputation
      has_many :reputations
      include InstanceMethods
    end
    
    module InstanceMethods
      def has_reputation?
        true
      end
    end
  end
end