require 'rails_helper'

describe 'when i want to create a new book' do

  it 'should show me a link to add a new book' do
    visit '/books'
    expect(page).to have_link("Add New Book")
  end

  it 'should take me to a new path when clicking on add new book' do
    visit '/books'
    click_on("Add New Book")
    expect(current_path).to eq(new_book_path)
  end

  it 'creates a new book' do
     visit new_book_path
     expect(page).to have_button('create')
     expect(page).to have_field('title')
     expect(page).to have_field('year')
     expect(page).to have_field('pages')
     expect(page).to have_field('authors')
   end

   it 'posts the new book to the book index page' do
     visit new_book_path

     fill_in(:book_title, with: "snow flower and the secret fan")
     fill_in(:book_year, with: 1987)
     fill_in(:book_pages, with: 200)
     fill_in(:book_authors, with: "Lisa See")

     find_button('Create Book').click
     #make book through author -- we will pass
     #form for checkboxes---do this on the view --- look at checkbox syntax for what the form box is called
     #dont see author - link to make a new one
     # save_and_open_page
    expect(page).to have_current_path(book_path)
  end

end
