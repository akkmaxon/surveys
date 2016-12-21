require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'must be valid' do
    company = Company.new(name: 'Company')
    expect(company).to be_valid
  end

  it 'must have a name' do
    company = Company.new
    expect(company).to be_invalid
  end
end
