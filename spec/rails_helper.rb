# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist
#Capybara.default_driver = :selenium

Capybara.default_max_wait_time = 5
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

module TestHelpers
  def init_data
    let(:user) { FactoryGirl.create :user }
    let!(:info) { FactoryGirl.create :info, user: user }

    let!(:question_1) { FactoryGirl.create :question, number: 1 }
    let!(:left_st_for_q_1) { FactoryGirl.create :left_statement, title: '1left', question: question_1 }
    let!(:right_st_for_q_1) { FactoryGirl.create :right_statement, title: '1right', question: question_1 }

    let!(:question_2) { FactoryGirl.create :question, number: 201, sentence: Faker::Lorem.sentence }

    let!(:question_28) { FactoryGirl.create :question, number: 28 }
    let!(:left_st_for_q_28) { FactoryGirl.create :left_statement, title: '28left', question: question_28 }
    let!(:right_st_for_q_28) { FactoryGirl.create :right_statement, title: '28right', question: question_28 }

    let!(:question_29) { FactoryGirl.create :question, number: 29 }
    let!(:left_st_for_q_29) { FactoryGirl.create :left_statement, title: '29left', question: question_29 }
    let!(:right_st_for_q_29) { FactoryGirl.create :right_statement, title: '29right', question: question_29 }
  end

  def take_a_survey
    find('#question_1_answer_1').trigger 'click'
    find('#question_28_answer_4').trigger 'click'
    find('#question_29_answer_2').trigger 'click'
    fill_in 'response_answer', with: 'answer sentence'
    find('.submit_questions_2').trigger 'click'
  end
end

include TestHelpers
