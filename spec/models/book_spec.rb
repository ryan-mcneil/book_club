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

  describe 'instance methods' do

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

      @author_1 = Author.create(name: "Author 1")
      @author_1.book_authors.create(book: @book_1)
      @author_2 = Author.create(name: "Author 2")
      @author_2.book_authors.create(book: @book_2)
      @author_3 = Author.create(name: "Author 3")
      @author_3.book_authors.create(book: @book_3)
      @author_4 = Author.create(name: "Author 4")
      @author_4.book_authors.create(book: @book_3)

    end

    it 'should calculate the average rating' do
      expect(@book_1.average_rating).to eq(2)
      expect(@book_2.average_rating).to eq(3)
    end

    it 'should find other authors' do
      expect(@book_3.other_authors(@author_3)). to eq([@author_4])
    end

  end

  describe 'class methods' do

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

      @author_1 = Author.create(name: "Author 1")
      @author_1.book_authors.create(book: @book_1)
      @author_2 = Author.create(name: "Author 2")
      @author_2.book_authors.create(book: @book_2)
      @author_3 = Author.create(name: "Author 3")
      @author_3.book_authors.create(book: @book_3)
      @author_4 = Author.create(name: "Author 4")
      @author_4.book_authors.create(book: @book_3)

    end

    it 'should sort by average rating' do
      expected_asc = [@book_3, @book_1, @book_2]
      expected_desc = [@book_2, @book_1, @book_3]

      expect(Book.sort_by("avg_rating", "ASC")).to eq(expected_asc)
      expect(Book.sort_by("avg_rating", "DESC")).to eq(expected_desc)
    end

    it 'should sort by number of pages' do
      expected_asc = [@book_3, @book_1, @book_2]
      expected_desc = [@book_2, @book_1, @book_3]

      expect(Book.sort_by("num_pages", "ASC")).to eq(expected_asc)
      expect(Book.sort_by("num_pages", "DESC")).to eq(expected_desc)
    end

    it 'should sort by number of reviews' do
      expected_asc = [@book_3, @book_2, @book_1]
      expected_desc = [@book_1, @book_2, @book_3]

      expect(Book.sort_by("num_reviews", "ASC")).to eq(expected_asc)
      expect(Book.sort_by("num_reviews", "DESC")).to eq(expected_desc)
    end

    it 'should find highest rated books' do
      expected = [@book_2, @book_1, @book_3]
      expect(Book.highest_rated).to eq(expected)
    end

    it 'should find lowest rated books' do
      expected = [@book_3, @book_1, @book_2]
      expect(Book.lowest_rated).to eq(expected)
    end

  end
end
