require 'rails_helper'

describe Review, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:score) }
  end

  describe 'Relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:book)}
  end

  describe 'Statistics' do
    
  end


  #I NEED TO WRITE A TEST FOR TOP AND BOTTOM REVIEWS
end
