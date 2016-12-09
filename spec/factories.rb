FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "user#{n}" }
    password "password"
  end

  factory :admin do
    login 'admin'
    sequence(:email) { |n| "admin#{n}@email.com" }
    password "password"
  end

  factory :coordinator do
    sequence(:login) { |n| "coordinator#{n}" }
    password "password"
  end

  factory :info do
    gender "мужской"
    experience "менее 1 года"
    age "менее 25 лет"
    workplace_number "второе"
    work_position "работник офиса"
    company 'Pepsi'
  end

  factory :response do
    answer "3"
    sequence(:question_number, 1)
    criterion "Criterion"
    criterion_type "Criterion Type"
  end
end
