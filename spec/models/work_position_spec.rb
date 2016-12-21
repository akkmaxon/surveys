require 'rails_helper'

RSpec.describe WorkPosition, type: :model do
  it 'must be valid' do
    wp = WorkPosition.new(title: 'Work Position')
    expect(wp).to be_valid
  end
  
  it 'must to have title' do
    wp = WorkPosition.new
    expect(wp).to be_invalid
  end
end
