FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:login) { |n| "login#{n}" }
    password "password"
    password_confirmation "password"
  end

  factory :info do
    gender 'male'
    experience 'less than 1 year'
    age 'from 25 to 30'
    workplace_number 'second'
    work_position 'office worker'
  end

  factory :survey do
  end 
end
