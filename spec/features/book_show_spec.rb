require 'rails_helper'

RSpec.describe 'as a visitor' do
  describe 'when i visit the book page' do
    it 'i should see the the books title' do
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
       user_2 = User.create(name: "User 2")

       user_2.reviews.create(
         title: "Terrible",
         description: "That was Awful!",
         score: 1,
         book: book_1)

       book_2 = Book.create(
         title: "Book 2",
         pages: 100,
         year: 1960)

       user_3 = User.create(name: "User 3")

       user_3.reviews.create(
         title: "Average",
         description: "That was Average!",
         score: 4, book: book_2)

       user_4 = User.create!(name: "User 4")

       user_4.reviews.create(
         title: "What's a book",
         description: "That was a book!",
         score: 2, book: book_2)

      visit "/books/#{book_1.id}"

      within(".book-stats") do
        expect(page).to have_content(book_1.title)
        expect(page).to have_content(book_1.authors.name)
        # expect(page).to have_content(book.reviews)
        expect(page).to have_content(book_1.pages)
      end
    end
  end
end
