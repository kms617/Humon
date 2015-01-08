class User < ActiveRecord::Base
  has_many :events
  validates :device_token, uniqueness: true
end
