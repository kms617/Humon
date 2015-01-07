class User < ActiveRecord::Base
  validates :device_token, uniqueness: true
  has_many :events
end
