class User < ActiveRecord::Base
  validates :device_token, uniqueness: true
end
