require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User creation' do
    let(:user) { FactoryGirl.build :user }
    let(:other_user) { FactoryGirl.build :user }

    context 'success' do
      it 'default properties' do
	user.save
	expect(user).to be_valid
      end

      it 'email is not required' do
	[nil, ''].each do |email|
	  user.email = email
	  expect(user).to be_valid
	end
      end

      it 'email is not unique' do
	other_user.email = user.email
	other_user.save
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

      it 'login must be unique' do
	other_user.login = user.login
	other_user.save
	expect(user).to be_invalid
      end

      it 'with short password' do
	user.password = user.password_confirmation = 'a' * 5
	expect(user).to be_invalid
      end
    end
  end
end
