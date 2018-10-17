require 'rails_helper'

RSpec.describe 'as a visitor' do
  describe 'when i visit the book page' do

    before(:each) do
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

      @author_1 = Author.create(name: "Author 1")
      @author_1.book_authors.create(book: @book_1)
      @author_2 = Author.create(name: "Author 2")
      @author_2.book_authors.create(book: @book_1)
    end

    it 'i should see the the books basic information' do

      visit book_path(@book_1)

      within(".book-stats") do
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@book_1.authors.first.name)
        expect(page).to have_content(@book_1.pages)
        expect(page).to have_content(@book_1.reviews.first.description)
        #wrap this in a tag and give id of review-1 (or whatever)
        #within that block i expect to see title, description, etc etc
        #.top_three_reviews
        #maybe visit again here?
        review = @book_1.reviews.top_reviews.first
        #look for within block, and test for individual things like review.title
        expect(page).to have_content(review.description)
        expect(page).to have_content(review.title)
        expect(page).to have_content(review.user.name)

        review_2 = @book_1.reviews.bottom_reviews.first
        expect(page).to have_content(review_2.description)
        expect(page).to have_content(review_2.title)
        expect(page).to have_content(review_2.user.name)

      end
    end

    it 'should link from index page' do

      visit books_path

      within "#book-#{@book_1.id}" do
        click_link "#{@book_1.title}"
      end

      expect(current_path).to eq(book_path(@book_1))
    end

    it 'should link from an author page' do

      visit author_path(@author_1)

      within "#book-#{@book_1.id}" do
        click_link "#{@book_1.title}"
      end

      expect(current_path).to eq(book_path(@book_1))
    end


  end
end

#you need to write tests for top and bottom three reviews show
