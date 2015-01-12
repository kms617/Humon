require 'faker'

FactoryGirl.define do
  factory :event do
    lat { Faker::Address.latitude.to_f.round(5) }
    lon { Faker::Address.longitude.to_f.round(5) }
    sequence(:name) { |n| "Name #{n}" }
    sequence(:started_at) { |n| n.hours.from_now }
    owner

    trait :intrepid do
      name 'Intrepid Labs'
      lat 42.36708
      lon (-71.08035)
    end

    trait :museum do
      name 'Museum of Science'
      lat 42.36673
      lon (-71.06761)
    end

    trait :cambridge do
      name 'Central Square'
      lat 42.36562
      lon (-71.10385)
    end

    trait :chicago do
      name 'Jackson Street Bridge'
      lat 41.88779
      lon (-87.623)
    end
  end

  factory :user, aliases: [:owner] do
    sequence(:device_token) { SecureRandom.hex(3) }
  end
end
