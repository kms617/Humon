require 'faker'
FactoryGirl.define do
  factory :event do
    lat { Faker::Address.latitude.to_f.round(5) }
    lon { Faker::Address.longitude.to_f.round(5) }
    sequence(:name) { |n| "Name #{n}" }
    sequence(:started_at) { |n| n.hours.from_now }
    owner
  end

  factory :user, aliases: [:owner] do
    sequence(:device_token) { SecureRandom.hex(3) }
  end
end
