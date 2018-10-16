require 'rails_helper'

describe "user deletes a review" do
  describe "they link from the user show page" do
    it "displays all reviews without the deleted entry" do

      @book_1 = Book.create(
        title: "Book 1",
        pages: 200,
        year: 2000)
      @user_1 = User.create(name: "User 1")
      @review_1 = @user_1.reviews.create(
        title: "Wonderful",
        description: "That was Fantastic!",
        score: 4,
        book: @book_1)
      @user_2 = User.create(name: "User 2")
      @review_2 = @user_2.reviews.create(
        title: "Terrible",
        description: "That was Awful!",
        score: 1,
        book: @book_1)
      @user_3 = User.create(name: "User 3")
      @review_3 = @user_3.reviews.create(
        title: "Special",
        description: "That was Special!",
        score: 1,
        book: @book_1)

      @book_2 = Book.create(
        title: "Book 2",
        pages: 300,
        year: 1960)
      @review_4 = @user_1.reviews.create(
        title: "Average",
        description: "That was Average!",
        score: 2,
        book: @book_2)
      @review_5 = @user_2.reviews.create(
        title: "What's a book",
        description: "That was a book!",
        score: 4,
        book: @book_2)

      @book_3 = Book.create(
        title: "Book 3",
        pages: 100,
        year: 1980)
      @review_5 = @user_2.reviews.create(
        title: "Amazing",
        description: "That was Amazing!",
        score: 1,
        book: @book_3)

      @author_1 = Author.create(name: "Author 1")
      @author_1.book_authors.create(book: @book_1)
      @author_2 = Author.create(name: "Author 2")
      @author_2.book_authors.create(book: @book_1)
      @author_3 = Author.create(name: "Author 3")
      @author_3.book_authors.create(book: @book_2)
      @author_4 = Author.create(name: "Author 4")
      @author_4.book_authors.create(book: @book_3)




      visit book_path(@book_1)

      click_link "Delete"

      expect(current_path).to eq(books_path)
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content(@book_3.title)
      expect(page).to_not have_content(@book_1.title)

      expect(Book.all).to include(@book_2)
      expect(Book.all).to_not include(@book_1)

      expect(Review.all).to_not include(@review_1)
      expect(Review.all).to_not include(@review_2)
      expect(Review.all).to_not include(@review_3)


    end
  end
end
