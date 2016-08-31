require 'rails_helper'

RSpec.describe Info, type: :model do
  describe 'Info creation' do
    let(:user) { FactoryGirl.create :user }
    let(:info) { FactoryGirl.build :info, user: user }

    context 'success' do
      it 'default values' do
	info.save
	expect(info).to be_valid
	expect(user.info).to eq info
      end
    end

    context 'fails' do
      it 'gender is empty' do
	info.gender = ''
	expect(info).to be_invalid
      end

      it 'experience is empty' do
	info.experience = ''
	expect(info).to be_invalid
      end

      it 'age is empty' do
	info.age = ''
	expect(info).to be_invalid
      end

      it 'workplace_number is empty' do
	info.workplace_number = ''
	expect(info).to be_invalid
      end

      it 'work_position is empty' do
	info.work_position = ''
	expect(info).to be_invalid
      end

      it 'company is empty' do
	info.company = ''
	expect(info).to be_invalid
      end
    end
  end
end
