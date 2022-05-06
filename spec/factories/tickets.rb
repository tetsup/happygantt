FactoryBot.define do
  factory :ticket do
    name { '100ゴールド稼ぐ' }
    description { 'まず一番安い剣と盾を買う、そのためにお金が必要' }
    status { :notyet }
    association :requirement

    trait :without_name do
      name { nil }
    end

    trait :without_status do
      status { nil }
    end

    trait :without_requirement do
      requirement { nil }
    end

    trait :with_long_name do
      name { 'まず一番安い剣と盾を買う、そのためにお金が必要' }
    end

    trait :doing do
      status { :doing }
      started_date { '1981-12-31' }
    end

    trait :done do
      status { :done }
      started_date { '1981-12-31' }
      ended_date { '1982-01-01' }
    end
  end
end
