require 'rails_helper'

describe 'when I visit the books index' do

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

  it 'should show all books' do

    visit '/books'

    expect(page).to have_content(@book_1.title)
    expect(page).to have_content("Author: #{@book_1.authors.first.name}")
    expect(page).to have_content("Pages: #{@book_1.pages}")
    expect(page).to have_content("Year: #{@book_1.year}")
    expect(page).to have_content("Total Reviews: 3")
    expect(page).to have_content("Average Rating: 2")

    expect(page).to have_content(@book_2.title)
    expect(page).to have_content("Author: #{@book_2.authors.first.name}")
    expect(page).to have_content("Pages: #{@book_2.pages}")
    expect(page).to have_content("Year: #{@book_2.year}")
    expect(page).to have_content("Total Reviews: 2")
    expect(page).to have_content("Average Rating: 3")

    expect(page).to have_content(@book_3.title)
    expect(page).to have_content("Authors: #{@book_3.authors.first.name}, #{@book_3.authors.last.name}")
    expect(page).to have_content("Pages: #{@book_3.pages}")
    expect(page).to have_content("Year: #{@book_3.year}")
    expect(page).to have_content("Total Reviews: 1")
    expect(page).to have_content("Average Rating: 1")
  end


  it 'should sort by rating, asc' do

    visit '/books'

    click_on 'sort_by_rating_asc'

    expect(page).to have_current_path('/books?sort=avg_rating&dir=ASC')

    within "#books" do
      expect(all(".book-title")[0]).to have_content(@book_3.title)
      expect(all(".book-title")[1]).to have_content(@book_1.title)
      expect(all(".book-title")[2]).to have_content(@book_2.title)
    end

  end

  it 'should sort by rating, desc' do

    visit '/books'

    click_on 'sort_by_rating_desc'

    expect(page).to have_current_path('/books?sort=avg_rating&dir=DESC')

    within "#books" do
      expect(all(".book-title")[0]).to have_content(@book_2.title)
      expect(all(".book-title")[1]).to have_content(@book_1.title)
      expect(all(".book-title")[2]).to have_content(@book_3.title)
    end

  end

  it 'should sort by number of pages, asc' do

    visit '/books'

    click_on 'sort_by_pages_asc'

    expect(page).to have_current_path('/books?sort=num_pages&dir=ASC')

    within "#books" do
      expect(all(".book-title")[0]).to have_content(@book_3.title)
      expect(all(".book-title")[1]).to have_content(@book_1.title)
      expect(all(".book-title")[2]).to have_content(@book_2.title)
    end

  end

  it 'should sort by number of pages, desc' do

    visit '/books'

    click_on 'sort_by_pages_desc'

    expect(page).to have_current_path('/books?sort=num_pages&dir=DESC')

    within "#books" do
      expect(all(".book-title")[0]).to have_content(@book_2.title)
      expect(all(".book-title")[1]).to have_content(@book_1.title)
      expect(all(".book-title")[2]).to have_content(@book_3.title)
    end

  end

  it 'should sort by number of reviews, asc' do

    visit '/books'

    click_on 'sort_by_reviews_asc'

    expect(page).to have_current_path('/books?sort=num_reviews&dir=ASC')

    within "#books" do
      expect(all(".book-title")[0]).to have_content(@book_3.title)
      expect(all(".book-title")[1]).to have_content(@book_2.title)
      expect(all(".book-title")[2]).to have_content(@book_1.title)
    end

  end

  it 'should sort by number of reviews, desc' do

    visit '/books'

    click_on 'sort_by_reviews_desc'

    expect(page).to have_current_path('/books?sort=num_reviews&dir=DESC')

    within "#books" do
      expect(all(".book-title")[0]).to have_content(@book_1.title)
      expect(all(".book-title")[1]).to have_content(@book_2.title)
      expect(all(".book-title")[2]).to have_content(@book_3.title)
    end

  end

  it 'should find highest rated books' do

    visit '/books'

    within "#highest-rated" do
      expect(all(".book-title")[0]).to have_content(@book_2.title)
      expect(all(".book-title")[1]).to have_content(@book_1.title)
      expect(all(".book-title")[2]).to have_content(@book_3.title)
    end

  end

  it 'should find lowest rated books' do

    visit '/books'

    within "#lowest-rated" do
      expect(all(".book-title")[0]).to have_content(@book_3.title)
      expect(all(".book-title")[1]).to have_content(@book_1.title)
      expect(all(".book-title")[2]).to have_content(@book_2.title)
    end

  end

  it 'should find most active users' do

    visit '/books'

    within "#most-active" do
      expect(all(".username")[0]).to have_content(@user_2.name)
      expect(all(".username")[1]).to have_content(@user_1.name)
      expect(all(".username")[2]).to have_content(@user_3.name)
    end

  end

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

     fill_in('title', with: "snow flower and the secret fan")
     fill_in('year', with: 1987)
     fill_in('pages', with: 200)
     fill_in('authors', with: "Lisa See")
     find_button('create').click
     save_and_open_page
    expect(page).to have_current_path(book_path)
  end
end


# it 'posts to the comedian homepage' do
# visit 'comedians/new'
#
# fill_in('name', with:'Ruth Brand')
# fill_in('age', with:'30')
# fill_in('city', with: 'Denver, CO')
# find_button('create').click
#
# expect(page).to have_current_path('/comedians')
# expect(page).to have_content "Ruth Brand"
# expect(page).to have_content "30"
# expect(page).to have_content "Denver, CO"
# end
# end

   # fill_in :image, with: "https://s13686.pcdn.co/wp-content/uploads/2017/11/mmf_johngotti_infographic_1992_blog-768x432.jpg"




#
# When I click that link, I am taken to a new book path.
# I can add a new book through a form, including the book's
# title, author(s), and number of pages in the book.
# When I submit the form, I am taken to that book's show page.

# Book titles should be converted to Title Case before saving.
# Book titles should be unique within the system.
# For authors, a comma-separated list of names should be entered,
# and each author will be added to the database.
