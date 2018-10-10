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
end
