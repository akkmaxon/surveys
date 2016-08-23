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
    work_position 'office worker'
    company 'Pepsi'
  end

  factory :survey do
  end 

  factory :response do
    question Faker::Lorem.sentence.gsub!('.', '?')
    answer Faker::Lorem.sentence
  end

  factory :question do
    text Faker::Lorem.sentence.gsub!('.', '?')
    audience 'management'
  end
end
