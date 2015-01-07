FactoryGirl.define do
  factory :event do
    lat
    lon
    name
    started_at
    owner factory: :user
  end

  factory :user do
    device_token { generate(:token) }
  end
end
