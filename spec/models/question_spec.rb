require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { FactoryGirl.build :question }

  describe 'Question creation' do
    context 'success' do
      it 'default' do
	question.save
	expect(question).to be_valid
      end

      it 'audience in proper range' do
	["Менеджмент", "Рабочая специальность"].each do |a|
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

      it 'criterion_type is empty' do
	question.criterion_type = ''
	expect(question).to be_valid
      end

      it 'criterion_type in proper range' do
	["Вовлеченность", "Удовлетворенность", "Отношение к руководству" ].each do |t|
	  question.criterion_type = t
	  expect(question).to be_valid
	end
      end
    end

    context 'fails' do
      after do
	expect(question).to be_invalid
      end

      it 'with empty audience' do
	question.audience = ''
      end

      it 'when criterion is empty' do
	question.criterion = ''
      end

      it 'when audience in wrong range' do
	%w[teacher programmer seller].each do |a|
	  question.audience = a
	end
      end

      it 'opinion_subject in wrong range' do
	%w[ you they ].each do |o|
	  question.opinion_subject = o
	end
      end

      it 'when criterion_type is wrong' do
	%w[ orange apple ].each do |t|
	  question.criterion_type = t
	end
      end
    end
  end

  describe 'Deleting behaviour' do
    let!(:left_st) { FactoryGirl.create :left_statement, question: question }
    let!(:right_st) { FactoryGirl.create :right_statement, question: question }

    it 'delete left and right statement automatically' do
      expect(LeftStatement.first).to eq left_st
      expect(RightStatement.first).to eq right_st
      question.destroy
      expect(LeftStatement.count).to eq 0
      expect(RightStatement.count).to eq 0
    end
  end

  describe 'methods' do
    let!(:q1) { FactoryGirl.create :question, criterion_type: "Вовлеченность", criterion: 'first_crit', number: 1 }
    let!(:q2) { FactoryGirl.create :question, criterion_type: "Вовлеченность", criterion: 'first_crit', number: 2 }
    let!(:q3) { FactoryGirl.create :question, criterion_type: "Вовлеченность", criterion: 'second_crit', number: 3 }
    let!(:q4) { FactoryGirl.create :question, criterion_type: "Вовлеченность", criterion: 'second_crit', number: 4 }
    let!(:q5) { FactoryGirl.create :question, criterion_type: "Удовлетворенность", criterion: 'third_crit', number: 5 }
    let!(:q6) { FactoryGirl.create :question, criterion_type: "Удовлетворенность", criterion: 'third_crit', number: 6 }
    let!(:q7) { FactoryGirl.create :question, criterion_type: "Удовлетворенность", criterion: 'fourth_crit', number: 7 }
    let!(:q8) { FactoryGirl.create :question, criterion_type: "Удовлетворенность", criterion: 'fourth_crit', number: 8 }
    let!(:user) { FactoryGirl.create :user }
    let!(:survey) { FactoryGirl.create :survey, user: user, audience: "Менеджмент", completed: true }

    it '.for' do
      q2.update(number: 1, audience: "Рабочая специальность")
      q3.update(number: 2, audience: "Рабочая специальность")
      expect(Question.for("Менеджмент").count).to eq 6
      expect(Question.for("Рабочая специальность").count).to eq 2
    end

    it '.first_questions_for' do
      first_questions = Question.first_questions_for(survey)
      expect(first_questions.count).to eq 8
      q1.update(sentence: Faker::Lorem.sentence)
      expect(first_questions.count).to eq 7
    end

    it '.second_questions_for' do
      second_questions = Question.second_questions_for(survey)
      expect(second_questions.count).to eq 0
      q1.update(sentence: Faker::Lorem.sentence)
      expect(second_questions.count).to eq 1
    end

    describe '.group_by_criterion' do
      context 'management' do
	it 'return involvements' do
	  criteria = Question.group_by_criterion(survey, "Вовлеченность")
	  expect(criteria).to eq({ 'first_crit' => [1,2], 'second_crit' => [3,4] })
	end

	it 'return satisfactions' do
	  criteria = Question.group_by_criterion(survey, "Удовлетворенность")
	  expect(criteria).to eq({ 'third_crit' => [5,6], 'fourth_crit' => [7,8] })
	end
      end

      context 'working_staff' do
	before do
	  [q1, q2, q5, q6].each do |question|
	    question.update audience: "Рабочая специальность"
	  end
	  survey.update audience: "Рабочая специальность"
	end

	it 'return involvements' do
	  criteria = Question.group_by_criterion(survey, "Вовлеченность")
	  expect(criteria).to eq({ 'first_crit' => [1,2]})
	end

	it 'return satisfactions' do
	  criteria = Question.group_by_criterion(survey, "Удовлетворенность")
	  expect(criteria).to eq({ 'third_crit' => [5,6]})
	end
      end
    end
  end
end
