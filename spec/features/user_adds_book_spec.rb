require 'rails_helper'

describe'i can make a new book' do
 it 'the link is there and it goes somehwere' do
   # When I visit the book index page,
   visit books_path
   # I see a link that allows me to add a new book.
   expect(page).to have_link("Add New Book")
   # When I click that link, I am taken to a new book path.
   click_on("Add New Book")

   expect(current_path).to eq(new_author_book_path)
   # I can add a new book through a form, including the book's
   fill_in :title, with: "I dunno said Patrick"
   fill_in :pages, with: 300
   fill_in :year, with: 1992
   fill_in :authors, with: "God"
   fill_in :image, with: "https://s13686.pcdn.co/wp-content/uploads/2017/11/mmf_johngotti_infographic_1992_blog-768x432.jpg"
   # title, author(s), and number of pages in the book.
   # When I submit the form, I am taken to that book's show page.
   click_on("submit")

   #write some kind of save funtionaliy to make a new book


   expect(current_path).to eq(book_path(Book.all.last))
    end

   it 'makes the book into camel case' do
    expect(page).to have_content("I Dunno Said Patrick")
   end

   # Book titles should be unique within the system. -- this is in the model as well, doesnt need to be in view

   # For authors, a comma-separated list of names should be entered,
   # and each author will be added to the database. ---- how the fuck do i write a test for this?
end
