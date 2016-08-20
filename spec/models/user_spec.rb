require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User creation' do
    let(:user) { FactoryGirl.build :user }

    context 'success' do
      it 'default properties' do
	user.save
	expect(user).to be_valid
      end
    end

    context 'fails' do
      it 'with empty login' do
	user.login = ''
	expect(user).to be_invalid
      end

      it 'with long login' do
	user.login = 'a' * 65
	expect(user).to be_invalid
      end

      it 'with empty email' do
	user.email = ''
	expect(user).to be_invalid
      end

      it 'with short password' do
	user.password = user.password_confirmation = 'a' * 7
	expect(user).to be_invalid
      end
    end
  end
end
