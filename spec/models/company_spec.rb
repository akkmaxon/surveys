require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { FactoryGirl.build :company }
  it 'must be valid' do
    company.save
    expect(company).to be_valid
  end

  it 'company must have a name' do
    company.name = ''
    expect(company).to be_invalid
  end
end
