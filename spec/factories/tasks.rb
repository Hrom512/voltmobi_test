FactoryGirl.define do
  factory :task do
    association :user
    sequence(:name) { |n| "Task #{n}" }
    description 'Task description'
  end
end
