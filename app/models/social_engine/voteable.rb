module SocialEngine
  module Voteable
    def is_voteable
      has_many :votes, :as=>:voteable, :dependent=>:destroy
      include InstanceMethods
    end
    
    module InstanceMethods
      def voteable?
        true
      end
      
      def upvote(options={})
        options.reverse_merge!(:value=>1)
        self.votes.create(options)
      end
      
      def downvote(options={})
        options.reverse_merge!(:value=>-1)
        self.votes.create(options)
      end
      
      def vote_sum
        self.votes.inject(0){|sum,vote| sum = sum + vote.value}
      end      
    end
  end
end