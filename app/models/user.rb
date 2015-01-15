class User < ActiveRecord::Base
  has_many :events
  validates :device_token, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
