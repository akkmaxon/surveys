# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist

Capybara.default_max_wait_time = 5
Capybara.raise_server_errors = false
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :feature
end

module MyTestHelpers
  def init_data
    let(:user) { FactoryGirl.create :user }
    let!(:info) { FactoryGirl.create :info, user: user }
    ### 1st questions 1,28, 29 for management
    let!(:q1_m) { FactoryGirl.create :question, number: 1 }
    let!(:left_for_q1m) { FactoryGirl.create :left_statement, title: '1left', question: q1_m }
    let!(:right_for_q1m) { FactoryGirl.create :right_statement, title: '1right', question: q1_m }

    let!(:q29_m) { FactoryGirl.create :question, number: 29 }
    let!(:left_for_q29_m) { FactoryGirl.create :left_statement, title: '29left', question: q29_m }
    let!(:right_for_q29_m) { FactoryGirl.create :right_statement, title: '29right', question: q29_m }

    let!(:q30_m) { FactoryGirl.create :question, number: 30 }
    let!(:left_for_q30_m) { FactoryGirl.create :left_statement, title: '30left', question: q30_m }
    let!(:right_for_q30_m) { FactoryGirl.create :right_statement, title: '30right', question: q30_m }
    ### 2nd question for management
    let!(:q201_m) { FactoryGirl.create :question, number: 201, sentence: Faker::Lorem.sentence, criterion: "Свободные ответы", criterion_type: "" }
    ### 1st questions 1,28, 29 for working_staff
    let!(:q1_w) { FactoryGirl.create :question, number: 1, audience: "Рабочая специальность" }
    let!(:left_for_q1_w) { FactoryGirl.create :left_statement, title: '1left', question: q1_w }
    let!(:right_for_q1_w) { FactoryGirl.create :right_statement, title: '1right', question: q1_w }

    let!(:q29_w) { FactoryGirl.create :question, number: 29, audience: "Рабочая специальность" }
    let!(:left_for_q29_w) { FactoryGirl.create :left_statement, title: '29left', question: q29_w }
    let!(:right_for_q29_w) { FactoryGirl.create :right_statement, title: '29right', question: q29_w }

    let!(:q30_w) { FactoryGirl.create :question, number: 30, audience: "Рабочая специальность" }
    let!(:left_for_q30_w) { FactoryGirl.create :left_statement, title: '30left', question: q30_w }
    let!(:right_for_q30_w) { FactoryGirl.create :right_statement, title: '30right', question: q30_w }
    ### 2nd question for working_staff
    let!(:q201_w) { FactoryGirl.create :question, number: 201, sentence: Faker::Lorem.sentence, audience: "Рабочая специальность", criterion: "Свободные ответы", criterion_type: "" }
  end

  def take_a_survey
    find('#question_1_answer_1').trigger 'click'
    find('#question_29_answer_4').trigger 'click'
    find('#question_30_answer_2').trigger 'click'
    fill_in id: 'question_201_answer', with: 'answer sentence'
    find('.submit_questions_2').trigger 'click'
  end
end

include MyTestHelpers
