require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) do
    Question.new opinion_subject: "Я",
      audience: "Менеджмент",
      number: 1,
      title: "Title",
      criterion: "Criterion",
      criterion_type: "Вовлеченность"
  end

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
    it 'delete left and right statement automatically' do
      LeftStatement.create! title: "Title", text: "Text", question: question
      RightStatement.create! title: "Title", text: "Text", question: question
      expect(LeftStatement.count).to eq(1)
      expect(RightStatement.count).to eq(1)
      question.destroy
      expect(LeftStatement.count).to eq(0)
      expect(RightStatement.count).to eq(0)
    end
  end

  describe 'methods' do
    fixtures :questions

    let!(:user) { FactoryGirl.create :user }
    let!(:survey) { Survey.create! user: user, audience: "Менеджмент", completed: true }

    it '.for' do
      expect(Question.for("Менеджмент").count).to eq 4
      expect(Question.for("Рабочая специальность").count).to eq 4
      questions(:question1_management).
	update(audience: "Рабочая специальность")
      questions(:question29_management).
	update(audience: "Рабочая специальность")
      expect(Question.for("Менеджмент").count).to eq 2
      expect(Question.for("Рабочая специальность").count).to eq 6
    end

    it '.first_questions_for' do
      first_questions = Question.first_questions_for(survey)
      expect(first_questions.count).to eq 3
      questions(:question1_management).
	update(sentence: Faker::Lorem.sentence)
      expect(first_questions.count).to eq 2
    end

    it '.second_questions_for' do
      second_questions = Question.second_questions_for(survey)
      expect(second_questions.count).to eq 1
      questions(:question1_management).
	update(sentence: Faker::Lorem.sentence)
      expect(second_questions.count).to eq 2
    end
  end
end
