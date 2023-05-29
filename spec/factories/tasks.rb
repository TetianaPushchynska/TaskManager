FactoryBot.define do
  factory :task do
    association :user, factory: :user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    priority { Task::PRIORITIES.keys.sample }
    status { Task::STATUSES.keys.sample }
  end
end
