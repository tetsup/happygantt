FactoryBot.define do
  factory :mission_user_relationship do
    association :mission
    association :user
  end
end
