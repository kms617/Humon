require 'faker'
FactoryGirl.define do

  sequence :token do
    SecureRandom.hex(3)
  end

  factory :event do
    lat {Faker::Address.latitude.to_f.round(5)}
    lon {Faker::Address.longitude.to_f.round(5)}
    sequence(:name) { |n| "Name #{n}"}
    sequence(:started_at) { |n| n.hours.from_now}
    owner factory: :user
  end

  factory :user do
    device_token { generate(:token) }
  end
end
