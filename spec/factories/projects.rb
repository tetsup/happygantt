FactoryBot.define do
  factory :project do
    name { '地球の悪い奴をやっつける' }
    description { '地球には利権に溺れしがみつくやばい奴らがいっぱいいる' }
    status { :notyet }
    association :mission

    trait :without_name do
      name { nil }
    end

    trait :without_status do
      status { nil }
    end

    trait :without_mission do
      mission { nil }
    end

    trait :with_long_name do
      name { '地球には利権に溺れしがみつくやばい奴らがいっぱいいる' }
    end
  end
end
