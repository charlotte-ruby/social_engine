module SocialEngine
  module Friendable
    def is_friendable

      # Setup conditions
      active = ["confirmed = ? AND rejected = ?", true, false]
      pending = ["confirmed = ?", false]
      requested = ["confirmed = ? AND rejected = ?", false, false]
      rejected = ["rejected = ?", true]

      # Active friendships
      has_many :friendorings, :class_name=>'Friending',
               :foreign_key=>:friendee_id, :conditions=>active
      has_many :friendeeings, :class_name=>'Friending',
               :foreign_key=>:friendor_id, :conditions=>active
      # Pending friend requests from the user
      has_many :pending_friendships, :class_name=>'Friending',
               :foreign_key=>:friendor_id, :conditions=>pending
      # Pending friend requests to the user
      has_many :friend_requests, :class_name=>'Friending',
               :foreign_key=>:friendee_id, :conditions=>requested
      # Friend requests rejected by the user
      has_many :friend_rejections, :class_name=>'Friending',
               :foreign_key=>:friendee_id, :conditions=>rejected

      # Friend relations (these return collections of Users)
      has_many :friendors, :through=>:friendorings, :class_name=>'User'
      has_many :friendees, :through=>:friendeeings, :class_name=>'User'
      has_many :pending_friends, :through=>:pending_friendships,
               :source=>:friendee, :class_name=>'User'
      has_many :requesting_friends, :through=>:friend_requests,
               :source=>:friendor, :class_name=>'User'
      has_many :rejected_friends, :through=>:friend_rejections,
               :source=>:friendor, :class_name=>'User'

      include InstanceMethods
    end
    
    module InstanceMethods      
      def friendable?
        true
      end
      
      def friends(expire_association_cache=false)
        return self.friendors(true) + self.friendees(true) if expire_association_cache
        self.friendors + self.friendees
      end

      def add_friend(user)
        Friending.create(:friendor_id=>self.id, :friendee_id=>user.id,
                         :confirmed=>!SocialEngineYetting.confirm_friends)
      end
      
    end
  end
end
