require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'Response creation' do
    let(:user) { FactoryGirl.create :user }
    let!(:survey) { FactoryGirl.create :survey, user: user }
    let!(:question) { FactoryGirl.create :question }
    let!(:response) { survey.responses.build FactoryGirl.attributes_for(:response) }

    context 'success' do
      it 'default values' do
	expect(response).to be_valid
	expect(survey.responses.first).to eq response
      end
    end

    context 'fails' do
      it 'question number is nil' do
	response.question_number = nil
	expect(response).to be_invalid
      end

      it 'question number is not a number' do
	response.question_number = 'string'
	expect(response).to be_invalid
      end
    end
  end
end
