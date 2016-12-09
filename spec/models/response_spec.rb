require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'Response creation' do
    let(:user) { FactoryGirl.create :user }
    let(:survey) { Survey.create! user: user }
    let!(:response) do
      Response.new answer: "3",
	survey: survey,
	question_number: 1,
	sentence: "",
	criterion: "Criterion",
	criterion_type: "Criterion Type",
	opinion_subject: "Я"
    end

    context 'success' do
      it 'default values' do
	expect(response).to be_valid
	response.save
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
