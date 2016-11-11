FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "login#{n}" }
    password "password"
  end

  factory :admin do
    login 'admin'
    sequence(:email) { |n| "admin#{n}@email.com" }
    password "password"
  end

  factory :coordinator do
    sequence(:login) { |n| "login#{n}" }
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

  factory :survey do
  end 

  factory :response do
    answer Faker::Lorem.sentence
    sequence(:question_number, 1)
    criterion "Default Criterion"
    criterion_type "Default Criterion Type"
  end

  factory :question do
    sequence(:number, 1)
    audience 'Менеджмент'
    opinion_subject 'Я'
    title Faker::Lorem.sentence
    criterion Faker::Lorem.sentence
    criterion_type 'Вовлеченность'
  end

  factory :left_statement do
    title Faker::Lorem.sentence
    text Faker::Lorem.paragraph
  end
    
  factory :right_statement do
    title Faker::Lorem.sentence
    text Faker::Lorem.paragraph
  end

  factory :company do
    name Faker::Lorem.sentence
  end
end
