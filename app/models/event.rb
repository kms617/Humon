class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  validates_presence_of :address
  validates_presence_of :lat
  validates_presence_of :lon
  validates_presence_of :name
  validates_presence_of :started_at

  reverse_geocoded_by :lat, :lon
end
