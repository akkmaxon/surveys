require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'Response creation' do
    let(:user) { FactoryGirl.create :user }
    let(:survey) { FactoryGirl.create :survey, user: user }
    let(:response) { survey.responses.build FactoryGirl.attributes_for(:response) }

    context 'success' do
      it 'default values' do
	response.save
	expect(response).to be_valid
	expect(survey.responses.first).to eq response
      end
    end

    context 'fails' do
      it 'question is empty' do
	response.question = ''
	expect(response).to be_invalid
      end

      it 'answer is empty' do
	response.answer = ''
	expect(response).to be_invalid
      end
    end
  end
end
