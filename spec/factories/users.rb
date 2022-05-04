FactoryBot.define do
  factory :user do
    name { 'Ariel' }
    email { 'ariel@example.com' }
    password { 'test-password-ariel' }
    time_zone { :Tokyo }

    trait :without_name do
      name { nil }
    end

    trait :without_email do
      email { nil }
    end

    trait :without_password do
      password { nil }
    end

    trait :without_timezone do
      time_zone { nil }
    end

    trait :with_wrong_timezone do
      time_zone { 'Honjamaka Kingdom' }
    end
  end
end
