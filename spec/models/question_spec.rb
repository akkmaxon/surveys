require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'Question creation' do
    let(:question) { FactoryGirl.build :question }

    context 'success' do
      it 'successfully' do
	question.save
	expect(question).to be_valid
      end

      it 'audience in proper range' do
	%w[management working_staff].each do |a|
	  question.audience = a
	  expect(question).to be_valid
	end
      end
    end

    context 'fails' do
      it 'with empty value' do
	question.text = ''
	expect(question).to be_invalid
      end

      it 'with empty audience' do
	question.audience = ''
	expect(question).to be_invalid
      end

      it 'when audience in wrong range' do
	%w[teacher programmer seller].each do |a|
	  question.audience = a
	  expect(question).to be_invalid
	end
      end
    end
  end
end
