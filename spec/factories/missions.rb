FactoryBot.define do
  factory :mission do
    name { '地球を救う' }
    description { '地球が数年後には滅んでしまう！何とかしなければ！' }
    status { :notyet }

    trait :without_name do
      name { nil }
    end

    trait :without_status do
      status { nil }
    end

    trait :with_long_name do
      name { '地球が数年後には滅んでしまう！何とかしなければ！' }
    end
  end
end
