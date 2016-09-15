require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin) { FactoryGirl.build :admin }
  let(:other_admin) { FactoryGirl.build :admin }

  describe 'admin creation' do
    context 'success' do
      it 'default properties' do
	admin.save
	expect(admin).to be_valid
      end

      it 'good email' do
	['a@b.c', 'me.and@you.com', 'a_b@c.d'].each do |email|
	  admin.email = email
	  expect(admin).to be_valid
	end
      end
    end

    context 'fails' do
      it 'with empty login' do
	admin.login = ''
	expect(admin).to be_invalid
      end

      it 'with long login' do
	admin.login = 'a' * 65
	expect(admin).to be_invalid
      end

      it 'email required' do
	[nil, ''].each do |email|
	  admin.email = email
	  expect(admin).to be_invalid
	end
      end

      it 'email must be unique' do
	other_admin.email = admin.email
	other_admin.save
	expect(admin).to be_invalid
      end

      it 'bad email' do
	['a.b.c', 'a_and_b'].each do |email|
	  admin.email = email
	  expect(admin).to be_invalid
	end
      end

      it 'with short password' do
	admin.password = admin.password_confirmation = 'a' * 5
	expect(admin).to be_invalid
      end
    end
  end
end
