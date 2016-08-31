require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'Question creation' do
    let(:question) { FactoryGirl.build :question }

    context 'success' do
      it 'default' do
	question.save
	expect(question).to be_valid
      end

      it 'audience in proper range' do
	%w[management working_staff].each do |a|
	  question.audience = a
	  expect(question).to be_valid
	end
      end

      it 'opinion_subject in proper range' do
	["Я", "Мои коллеги"].each do |o|
	  question.opinion_subject = o
	  expect(question).to be_valid
	end
      end

      it 'responds to left and right statements' do
	expect(question.respond_to? :left_statement).to eq true
	expect(question.respond_to? :right_statement).to eq true
      end
    end

    context 'fails' do
      it 'with empty audience' do
	question.audience = ''
	expect(question).to be_invalid
      end

      it 'when criterion is empty' do
	question.criterion = ''
	expect(question).to be_invalid
      end

      it 'when audience in wrong range' do
	%w[teacher programmer seller].each do |a|
	  question.audience = a
	  expect(question).to be_invalid
	end
      end

      it 'opinion_subject in wrong range' do
	%w[ you they ].each do |o|
	  question.opinion_subject = o
	  expect(question).to be_invalid
	end
      end
    end
  end
end
