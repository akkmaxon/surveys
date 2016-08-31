require 'rails_helper'

RSpec.describe Survey, type: :model do
  let(:user) { FactoryGirl.create :user }
  let(:survey) { user.surveys.build FactoryGirl.attributes_for(:survey) }

  describe 'Survey creation' do
    context 'success' do
      it 'default values' do
	survey.save!
	expect(survey).to be_valid
	expect(user.surveys.first).to eq survey
      end
    end

    context 'fails' do
      it 'created independently from user' do
	survey = FactoryGirl.build :survey
	expect(survey).to be_invalid
      end
    end
  end

  describe 'Testing methods' do
    let!(:resp1) do 
      FactoryGirl.create :response, survey: survey,
      question_number: 1,
      answer: '1response'
    end
    let!(:resp2) do
      FactoryGirl.create :response, survey: survey,
	question_number: 2,
	answer: '2response'
    end

    describe '#answer_for' do
      it 'return nil' do
	wrong_number = 9
	expect(survey.answer_for(wrong_number)).to be_nil
      end

      it 'successfully' do
	expect(survey.answer_for(1)).to eq '1response'
	expect(survey.answer_for(2)).to eq '2response'
      end
    end

    describe '#sum_of' do
      it 'without parameters' do
	allow(survey).to receive(:answer_for).and_return("5")
	result = survey.sum_of
	expect(result).to eq 0
      end

      it 'with parameters' do
	allow(survey).to receive(:answer_for).and_return("5")
	expect(survey.sum_of([1,2])).to eq 10
	expect(survey.sum_of([3,4,5])).to eq 15
	expect(survey.sum_of([6,7,8,9,10])).to eq 25
      end
    end
  end
end
