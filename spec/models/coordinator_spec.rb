require 'rails_helper'

RSpec.describe Coordinator, type: :model do
  describe 'creation' do
    let(:coordinator) { FactoryGirl.create :coordinator }

    context 'successfully' do
      it 'login and password' do
	expect(coordinator).to be_valid
      end
    end

    context 'unsuccessfully' do
      after do
	expect(coordinator).to be_invalid
      end

      it 'with empty login' do
	coordinator.login = ''
      end

      it 'with too long login' do
	coordinator.login = 'a' * 65
      end

      it 'with not unique login' do
	FactoryGirl.create :coordinator, login: 'login'
	coordinator.login = 'login'
      end

      it 'without password' do
	coordinator.password = coordinator.password_confirmation = ''
      end

      it 'with short password' do
	coordinator.password = coordinator.password_confirmation = 'abc'
      end

      it 'with too long password' do
	coordinator.password = coordinator.password_confirmation = 'a' * 129
      end

      it 'with invalid password confirmation' do
	coordinator.password = 'password'
	coordinator.password_confirmation = 'password123'
      end
    end
  end
end
