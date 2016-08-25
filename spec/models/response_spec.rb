require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'Response creation' do
    let(:user) { FactoryGirl.create :user }
    let!(:survey) { FactoryGirl.create :survey, user: user }
    let!(:question) { FactoryGirl.create :question }
    let!(:response) { survey.responses.build FactoryGirl.attributes_for(:response).merge(question: question) }

    context 'success' do
      it 'default values' do
	expect(response).to be_valid
	expect(survey.responses.first).to eq response
      end
    end

    context 'fails' do
      it 'answer is empty' do
	response.answer = ''
	expect(response).to be_invalid
      end

      it 'question id is nil' do
	response.question_id = nil
	expect(response).to be_invalid
      end
    end
  end
end
