require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build :user }
  let(:other_user) { FactoryGirl.build :user }

  describe 'User creation' do
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
  
  describe 'Deleting' do
    let(:survey) { Survey.create! user: user }
    let!(:resp1) { FactoryGirl.create :response, survey: survey }
    let!(:resp2) { FactoryGirl.create :response, survey: survey }
    let!(:info) { FactoryGirl.create :info, user: user }

    before do
      expect(Survey.count).to eq 1
      expect(Response.count).to eq 2
      expect(Info.count).to eq 1
    end

    after do
      expect(Survey.count).to eq 0
      expect(Response.count).to eq 0
      expect(Info.count).to eq 0
    end

    it 'automatically clean surveys with dependencies' do
      user.destroy
    end
  end

  describe 'methods' do
    describe '#manager?' do
      let!(:info) { FactoryGirl.create :info, user: user }

      it 'return true' do
	["производственный руководитель", "работник офиса", "руководитель отдела", "топ-менеджер"].each do |position|
	  user.info.work_position = position
	  expect(user).to be_manager
	end
      end

      it 'return false' do
	user.info.work_position = "рабочая должность"
	expect(user).not_to be_manager
      end

      it 'raise error when blank' do
	[nil, ""].each do |position|
	  user.info.work_position = position
	  expect(user.info).to be_invalid
	  expect{user.info.save!}.to raise_error(ActiveRecord::RecordInvalid)
	end
      end
    end

    describe 'count_completed_surveys' do
      let!(:s1) { Survey.create! user: user, completed: true }
      let!(:s2) { Survey.create! user: user, completed: true }
      let!(:s3) { Survey.create! user: user, completed: false }

      it 'first test' do
	expect(user.count_completed_surveys).to eq 2
      end

      it 'second test' do
	s3.update(completed: true)
	expect(user.count_completed_surveys).to eq 3
      end
    end
  end
end
