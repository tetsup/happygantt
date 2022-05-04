FactoryBot.define do
  factory :milestone do
    name { 'レベル10まで上げる' }
    description { '悪い奴を倒すには力をつける必要がある' }
    status { :notyet }
    association :project

    trait :without_name do
      name { nil }
    end

    trait :without_status do
      status { nil }
    end

    trait :without_project do
      project { nil }
    end

    trait :with_long_name do
      name { 'レベル10まで上げた後でボスを倒してさらにレベル20まで上げてボスを倒してレベル30まで上げてボスを倒す' }
    end
  end
end
