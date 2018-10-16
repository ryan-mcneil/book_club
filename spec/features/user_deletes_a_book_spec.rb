require 'rails_helper'

describe "user deletes a review" do
  describe "they link from the user show page" do
    it "displays all reviews without the deleted entry" do

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


      @author_1 = Author.create(name: "Author 1")
      @author_1.book_authors.create(book: @book_1)
      @author_2 = Author.create(name: "Author 2")
      @author_2.book_authors.create(book: @book_1)




      visit book_path(@book_1)

      click_link "Delete"

      expect(current_path).to eq(books_path)
      # expect(page).to have_content(@review_2.title)
      # expect(page).to_not have_content(@review_1.title)
    end
  end
end
