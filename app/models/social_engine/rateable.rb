module SocialEngine
  module Rateable
    def is_rateable
      has_many :ratings, :as=>:rateable, :dependent=>:destroy
      include InstanceMethods
    end
    
    module InstanceMethods
      def rateable?
        true
      end
      
      def avg_rating
        avg = self.ratings.sum(:value).to_f/self.rating_count.to_f rescue 0
        avg = 0 if avg.nan?
        avg
      end
      
      def avg_rating_formatted(decimal_places=1)
        return self.avg_rating.to_i.to_s if decimal_places==0
        sprintf("%.#{decimal_places}f", self.avg_rating)
      end
      
      def rating_count
        self.ratings.size
      end
      
      def avg_rating_round_half
        (avg_rating*2).round / 2.0
      end
    end
  end
end