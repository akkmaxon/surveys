require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the Admin::QuestionsHelper. For example:
#
# describe Admin::QuestionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe Admin::QuestionsHelper, type: :helper do
  describe '#next_number_for_question' do
    let(:question) { FactoryGirl.build :question, number: 1 }
    
    it 'return 1 for first questions' do
      result = next_number_for_question(Question.all_first_questions.last)
      expect(result).to eq 1
    end

    it 'return 1 for second questions' do
      result = next_number_for_question(Question.all_second_questions.last)
      expect(result).to eq 1
    end

    it 'return 2 for first questions' do
      question.save
      result = next_number_for_question(Question.all_first_questions.last)
      expect(result).to eq 2
    end

    it 'return 2 for second questions' do
      question.sentence = Faker::Lorem.sentence
      question.save
      result = next_number_for_question(Question.all_second_questions.last)
      expect(result).to eq 2
    end
  end
end
