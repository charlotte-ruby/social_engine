module SocialEngine
  module Friendable
    def is_friendable

      # Setup conditions
      confirmed = 'friendings.confirmed = ?'
      rejected = 'friendings.rejected = ?'
      active = ["#{confirmed} AND #{rejected}", true, false]
      pending = [confirmed, false]
      requested = ["#{confirmed} AND #{rejected}", false, false]

      has_and_belongs_to_many :friendors, :join_table=>:friendings,
        :foreign_key=>:friendee_id, :association_foreign_key=>:friendor_id,
        :conditions=>active, :class_name=>'User'
      has_and_belongs_to_many :friendees, :join_table=>:friendings,
        :foreign_key=>:friendor_id, :association_foreign_key=>:friendee_id,
        :conditions=>active, :class_name=>'User'
      has_and_belongs_to_many :pending_friends, :join_table=>:friendings,
        :foreign_key=>:friendor_id, :association_foreign_key=>:friendee_id,
        :conditions=>pending, :class_name=>'User'
      has_and_belongs_to_many :friend_requests, :join_table=>:friendings,
        :foreign_key=>:friendee_id, :association_foreign_key=>:friendor_id,
        :conditions=>requested, :class_name=>'User'
      has_and_belongs_to_many :rejected_friends, :join_table=>:friendings,
        :foreign_key=>:friendee_id, :association_foreign_key=>:friendor_id,
        :conditions=>rejected, :class_name=>'User'
               
      include InstanceMethods
    end
    
    module InstanceMethods
      def friendable?
        true
      end
      
      def friends
        self.friendors + self.friendees
      end
      
    end
  end
end
