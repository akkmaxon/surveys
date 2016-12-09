require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:user) { FactoryGirl.create :user }
  let!(:criterion_types) { ["Вовлеченность", "Удовлетворенность", "Отношение к руководству", ""] }
  let!(:criteria) { ["First Criterion", "Second Criterion", "Свободные ответы"] }
  
  before do
    Survey.all.each do |survey|
      criterion_types.each do |ctype|
	if ctype.empty?
	  2.times do |n|
	    FactoryGirl.create :response,
	      survey: survey,
	      question_number: "20#{n+1}".to_i,
	      sentence: Faker::Lorem.sentence,
	      answer: Faker::Lorem.sentence,
	      criterion: criteria[2],
	      criterion_type: ctype
	  end
	else
	  4.times do |n|
	    FactoryGirl.create :response,
	      survey: survey,
	      answer: "(rand(6) + 1)",
	      question_number: (survey.responses.count + 1),
	      opinion_subject: "#{n.odd? ? "Я" : "Мои коллеги"}",
	      sentence: "",
	      criterion: "#{(n == 0 || n == 1) ? criteria[0] : criteria[1]}",
	      criterion_type: ctype
	  end
	end
      end
    end
  end

  describe 'check initialization' do
    it 'summary' do
      expect(Survey.count).to eq 2
      expect(survey1.responses.count).to eq 14
      expect(survey2.responses.count).to eq 14
    end

    it 'criterion_types' do
      Survey.all.each do |survey|
	resp = survey.responses
	expect(resp.where(criterion_type: criterion_types[0]).count).to eq 4
	expect(resp.where(criterion_type: criterion_types[1]).count).to eq 4
	expect(resp.where(criterion_type: criterion_types[2]).count).to eq 4
	expect(resp.where(criterion_type: criterion_types[3]).count).to eq 2
      end
    end

    it 'criteria' do
      Survey.all.each do |survey|
	resp = survey.responses
	expect(resp.where(criterion_type: criterion_types[0],
	       criterion: criteria[0]).count).to eq 2
	expect(resp.where(criterion_type: criterion_types[0],
	       criterion: criteria[1]).count).to eq 2

	expect(resp.where(criterion_type: criterion_types[1],
	       criterion: criteria[0]).count).to eq 2
	expect(resp.where(criterion_type: criterion_types[1],
	       criterion: criteria[1]).count).to eq 2

	expect(resp.where(criterion_type: criterion_types[2],
	       criterion: criteria[0]).count).to eq 2
	expect(resp.where(criterion_type: criterion_types[2],
	       criterion: criteria[1]).count).to eq 2

	expect(resp.where(criterion_type: criterion_types[3],
	       criterion: criteria[2]).count).to eq 2
      end
    end
  end

  describe '#create_tables!' do
    pending 
  end

  describe '#choose_responses' do
    it 'without surveys' do
      expect(Report.new([]).responses).to eq []
    end

    it 'with one survey' do
      expect(Report.new([survey1]).responses.count).to eq 14
    end

    it 'with more than one survey' do
      expect(Report.new(Survey.all).responses.count).to eq 28
    end
  end

  describe '#set_criterion_type_summary' do
    let(:report) { Report.new([]) }

    it "Вовлеченность" do
      result = report.set_criterion_type_summary(criterion_types[0])
      expect(result).to eq("Общий уровень вовлеченности")
    end

    it "Удовлетворенность" do
      result = report.set_criterion_type_summary(criterion_types[1])
      expect(result).to eq("Общий уровень удовлетворенности")
    end

    it "Отношение к руководству" do
      result = report.set_criterion_type_summary(criterion_types[2])
      expect(result).to eq("Отношение к руководству (общее)")
    end

    it 'unknown type' do
      chance_word = Faker::Lorem.word
      result = report.set_criterion_type_summary(chance_word)
      expect(result).to eq(chance_word)
    end
  end

  describe '#set_rows_for_table' do
    let(:report) { Report.new([survey1]) }

    it 'successfully' do
      criterion_types.reject(&:empty?).each do |criterion_type|
	rows = report.set_rows_for_table(criterion_type)
	expect(rows.count).to eq(2)
	[0,1].each do |n|
	  expect(rows[n]).to have_key(:counter)
	  expect(rows[n]).to have_key(:criterion)
	  expect(rows[n]).to have_key(:question_numbers)
	  expect(rows[n]).to have_key(:answer_me)
	  expect(rows[n]).to have_key(:answer_colleagues)
	  expect(rows[n]).to have_key(:result)
	end
      end
    end
  end

  describe '#calculate_summary' do
    let(:report) { Report.new([]) }
    let(:rows) do
      [
	{ a: 'a', b: 'b', c: 'c', result: "1.1" },
	{ a: 'a', b: 'b', c: 'c', result: "2.2" },
	{ a: 'a', b: 'b', c: 'c', result: "3.3" },
	{ a: 'a', b: 'b', c: 'c', result: "4.4" }
      ] 
    end

    it 'very good' do
      expect(report.calculate_summary(rows)).to eq("2.29")
    end

    it 'with some "-" signs' do
      [0,2].each {|n| rows[n][:result] = '-'}
      expect(report.calculate_summary(rows)).to eq("2.75")
    end

    it 'with total sum == 0' do
      rows.map! { |row| row[:result] = "0.0"; row }
      expect(report.calculate_summary(rows)).to eq("-")
    end

    it 'with all "-" signs' do
      rows.map! {|row| row[:result] = '-'; row }
      expect(report.calculate_summary(rows)).to eq("-")
    end 
  end
end
