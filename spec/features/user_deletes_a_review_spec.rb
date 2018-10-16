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

      @book_2 = Book.create(
        title: "Book 2",
        pages: 300,
        year: 1960)
      @review_2 = @user_1.reviews.create(
        title: "Terrible",
        description: "That was Awful!",
        score: 1,
        book: @book_2)

      @book_3 = Book.create(
        title: "Book 3",
        pages: 100,
        year: 1980)
      @review_3 = @user_1.reviews.create(
        title: "Special",
        description: "That was Special!",
        score: 1,
        book: @book_3)



      visit user_path(@user_1)

      within "#review-#{@review_1.id}" do
        click_link "Delete"
      end

      expect(current_path).to eq(user_path(@user_1))
      expect(page).to have_content(@review_2.title)
      expect(page).to_not have_content(@review_1.title)
    end
  end
end
