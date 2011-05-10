class User < ActiveRecord::Base
  is_social
  has_reputation
end
