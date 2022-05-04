FactoryBot.define do
  factory :requirement do
    name { '装備が整えられている' }
    description { 'レベルを上げるには、装備を揃えて適正レベルのモブと戦う必要がある' }
    association :milestone

    trait :without_name do
      name { nil }
    end

    trait :without_milestone do
      milestone { nil }
    end

    trait :with_long_name do
      name { 'レベルを上げるには、装備を揃えて適正レベルのモブと戦う必要がある' }
    end
  end
end
