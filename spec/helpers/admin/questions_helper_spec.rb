require 'rails_helper'

RSpec.describe Admin::QuestionsHelper, type: :helper do
  describe '#set_number_for_question' do
    let(:question) { FactoryGirl.build :question, number: 1 }
    
    context 'creating question' do
      let(:new_q) { Question.new }
      
      it 'return default value for first questions' do
	result = set_number_for_question(new_q, 'first', Question.all_first_questions.last)
	expect(result).to eq 1
      end

      it 'return default value for second questions' do
	result = set_number_for_question(new_q, 'second', Question.all_second_questions.last)
	expect(result).to eq 201
      end

      it 'return last + 1 for first questions' do
	question.save
	result = set_number_for_question(new_q, 'first', Question.all_first_questions.last)
	expect(result).to eq 2
      end

      it 'return last + 1 for second questions' do
	question.sentence = Faker::Lorem.sentence
	question.save
	result = set_number_for_question(new_q, 'second', Question.all_second_questions.last)
	expect(result).to eq 2
      end
    end

    context 'updating question' do
      let(:edit_q) { FactoryGirl.create :question, number: 123 }
      
      it 'return existing number for first question' do
	result = set_number_for_question(edit_q, 'first', Question.all_first_questions.last)
	expect(result).to eq 123
      end

      it 'return existing number for first question' do
	result = set_number_for_question(edit_q, 'second', Question.all_second_questions.last)
	expect(result).to eq 123
      end
    end
  end
end
