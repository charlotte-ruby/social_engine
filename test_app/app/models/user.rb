class User < ActiveRecord::Base
  is_social
  is_friendable
  has_reputation
end
