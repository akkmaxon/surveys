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

  describe 'Survey deleting' do
    let!(:r1) { FactoryGirl.create :response, survey: survey }
    let!(:r2) { FactoryGirl.create :response, survey: survey }
    let!(:r3) { FactoryGirl.create :response, survey: survey }

    it 'automatically delete all responses' do
      expect(Response.count).to eq 3
      expect(survey.responses.count).to eq 3
      survey.destroy
      expect(Response.count).to eq 0
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

    describe '#total_assessment_for' do
      before do
	allow(survey).to receive(:answer_for).and_return("5")
	allow(survey).to receive(:report_correction).and_return(1.0)
      end

      it 'without parameters' do
	expect(survey.total_assessment_for).to eq nil
      end

      it 'with empty array in parameters' do
	expect(survey.total_assessment_for []).to eq nil
      end

      it 'with parameters' do
	expect(survey.total_assessment_for [1,2]).to eq 5.0
	expect(survey.total_assessment_for [3,4,5]).to eq 5.0
	expect(survey.total_assessment_for [6,7,8,9,10]).to eq 5.0
      end
    end

    describe '#reliable?' do
      let!(:resp1) { FactoryGirl.create :response, survey: survey, question_number: 29, answer: "4" }
      let!(:resp2) { FactoryGirl.create :response, survey: survey, question_number: 30, answer: "3" }

      it 'with values from middle' do
	expect(survey).to be_reliable
      end

      it 'with lowest values' do
	resp1.update answer: "1"
	resp2.update answer: "1"
	expect(survey).to be_reliable
      end

      it 'with sum == RSUM' do
	[["5", "6"], ["6", "5"]].each do |values|
	  resp1.update answer: values[0]
	  resp2.update answer: values[1]
	  expect(survey).not_to be_reliable
	end
      end

      it 'with sum > RSUM' do
	resp1.update answer: "6"
	resp2.update answer: "6"
	expect(survey).not_to be_reliable
      end
    end
  end
end
