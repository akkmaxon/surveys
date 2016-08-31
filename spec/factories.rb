FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "login#{n}" }
    email ""
    password "password"
    password_confirmation "password"
  end

  factory :info do
    gender 'male'
    experience 'less than 1 year'
    age 'from 25 to 30'
    workplace_number 'second'
    work_position 'руководитель отдела'
    company 'Pepsi'
  end

  factory :survey do
  end 

  factory :response do
    answer Faker::Lorem.sentence
    sequence(:question_number, 1)
  end

  factory :question do
    sequence(:number, 1)
    audience 'management'
    opinion_subject 'Я'
    criterion Faker::Lorem.sentence
  end

  factory :left_statement do
    title Faker::Lorem.sentence
    text Faker::Lorem.paragraph
  end
    
  factory :right_statement do
    title Faker::Lorem.sentence
    text Faker::Lorem.paragraph
  end
end
