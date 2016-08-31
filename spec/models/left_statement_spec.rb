require 'rails_helper'

RSpec.describe LeftStatement, type: :model do
  let(:question) { FactoryGirl.create :question }
  let(:left_st) { FactoryGirl.create :left_statement, question: question }

  it 'Creating with valid properties' do
    left_st.save
    expect(left_st).to be_valid
    expect(question.left_statement.title).to eq left_st.title
  end

  it 'Invalid if text is empty' do
    left_st.text = ''
    expect(left_st).to be_invalid
  end

end
