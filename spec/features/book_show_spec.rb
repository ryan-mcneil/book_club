require 'rails_helper'

RSpec.describe 'as a visitor' do
  describe 'when i visit the book page' do
      before(:each) do
        @book_1 = Book.create(
         title: "Book 1",
         pages: 200,
         year: 2000)
       user_1 = User.create(name: "User 1")

       author_1 = Author.create(
         name: "Betty"
        )

        book_authors_1 = @book_1.book_authors.create(author: author_1)

       user_1.reviews.create(
         title: "Wonderful",
         description: "That was Fantastic!",
         score: 4,
         book: @book_1)
       user_2 = User.create(name: "User 2")

       user_2.reviews.create(
         title: "Terrible",
         description: "That was Awful!",
         score: 1,
         book: @book_1)

       book_2 = Book.create(
         title: "Book 2",
         pages: 100,
         year: 1960)

       user_3 = User.create(name: "User 3")

       #save this as an instance variable, then call it down below in the block you made for it

       user_3.reviews.create(
         title: "Average",
         description: "That was Average!",
         score: 4, book: book_2)

       user_4 = User.create!(name: "User 4")

       user_4.reviews.create(
         title: "What's a book",
         description: "That was a book!",
         score: 2, book: book_2)
       end

      it 'i should see the the books basic information' do
      visit "/books/#{@book_1.id}"

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
      end
    end
  end
end

#you need to write tests for top and bottom three reviews show
