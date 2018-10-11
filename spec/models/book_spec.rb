require 'rails_helper'

describe Book, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:pages) }
    it { should validate_presence_of(:year) }
  end

  describe 'Relationship' do
    it { should have_many(:book_authors) }
    it { should have_many(:authors).through(:book_authors) }
    it { should have_many(:reviews)}
    it { should have_many(:users).through(:reviews)}
  end

  describe 'Statistics' do
    before(:each) do
    book_1 = Book.create(
      title: "Book 1",
      pages: 200,
      year: 2000)
    user_1 = User.create(name: "User 1")
    user_1.reviews.create(
      title: "Wonderful",
      description: "That was Fantastic!",
      score: 4,
      book: book_1)

    book_2 = Book.create(
      title: "Book 2",
      pages: 200,
      year: 2000)
    user_2 = User.create(name: "User 2")
    user_2.reviews.create(
      title: "Wonderful",
      description: "That was Fantastic!",
      score: 5,
      book: book_2)

      book_3 = Book.create(
        title: "Book 1",
        pages: 200,
        year: 2000)
      user_3 = User.create(name: "User 3")
      user_3.reviews.create(
        title: "Wonderful",
        description: "That was Fantastic!",
        score: 1,
        book: book_3)

        book_4 = Book.create(
          title: "Book 4",
          pages: 200,
          year: 2000)
        user_4 = User.create(name: "User 4")
        user_4.reviews.create(
          title: "Wonderful",
          description: "That was Fantastic!",
          score: 2,
          book: book_4)

     end

       it 'shows average review rating' do
         expect(Book.average_rating).to eq(3)
       end

  end
end
