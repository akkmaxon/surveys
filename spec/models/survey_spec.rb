require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe 'Survey creation' do
    let(:user) { FactoryGirl.create :user }
    let(:survey) { user.surveys.build FactoryGirl.attributes_for(:survey) }

    context 'success' do
      it 'default values' do
	survey.save!
	expect(survey).to be_valid
	expect(user.surveys.first).to eq survey
      end
    end

    context 'fails' do
    end
  end
end
