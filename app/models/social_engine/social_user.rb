module SocialEngine
  module SocialUser
    def is_social
      has_many :comments
      has_many :votes
      has_many :ratings
      has_many :favorites
      include InstanceMethods
    end
    module InstanceMethods
      def is_social?
        true
      end
    end
  end
end