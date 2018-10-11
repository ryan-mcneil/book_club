require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Relationship' do
    it { should have_many(:reviews) }
    it { should have_many(:books).through(:reviews) }
  end

  describe 'Statistics' do

    before(:each) do

      @book_1 = Book.create(
        title: "Book 1",
        pages: 200,
        year: 2000)
      @user_1 = User.create(name: "User 1")
      @user_1.reviews.create(
        title: "Wonderful",
        description: "That was Fantastic!",
        score: 4,
        book: @book_1)
      @user_2 = User.create(name: "User 2")
      @user_2.reviews.create(
        title: "Terrible",
        description: "That was Awful!",
        score: 1,
        book: @book_1)
      @user_3 = User.create(name: "User 3")
      @user_3.reviews.create(
        title: "Special",
        description: "That was Special!",
        score: 1,
        book: @book_1)

      @book_2 = Book.create(
        title: "Book 2",
        pages: 300,
        year: 1960)
      @user_1.reviews.create(
        title: "Average",
        description: "That was Average!",
        score: 4,
        book: @book_2)
      @user_2.reviews.create(
        title: "What's a book",
        description: "That was a book!",
        score: 2,
        book: @book_2)

      @book_3 = Book.create(
        title: "Book 3",
        pages: 100,
        year: 1980)
      @user_2.reviews.create(
        title: "Amazing",
        description: "That was Amazing!",
        score: 1,
        book: @book_3)
    end

    it 'should find most active users' do
      expected = [@user_2, @user_1, @user_3]
      expect(User.most_active).to eq(expected)
    end
  end
end
