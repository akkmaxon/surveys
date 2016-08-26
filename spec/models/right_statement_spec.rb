require 'rails_helper'

RSpec.describe RightStatement, type: :model do
  let(:question) { FactoryGirl.create :question }
  let(:right_st) { FactoryGirl.create :right_statement, question: question }

  it 'Creating with valid properties' do
    right_st.save
    expect(right_st).to be_valid
    expect(question.right_statement.title).to eq right_st.title
  end

  it 'Invalid if text is empty' do
    right_st.text = ''
    expect(right_st).to be_invalid
  end

end
