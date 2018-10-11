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
    @user_4 = User.create(name: "User 4")
    @user_4.reviews.create(
      title: "Average",
      description: "That was Average!",
      score: 4,
      book: @book_2)
    @user_5 = User.create(name: "User 5")
    @user_5.reviews.create(
      title: "What's a book",
      description: "That was a book!",
      score: 2,
      book: @book_2)

    @book_3 = Book.create(
      title: "Book 3",
      pages: 100,
      year: 1980)
    @user_6 = User.create(name: "User 6")
    @user_6.reviews.create(
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



    #within
    #expect(all(".class")[0]).to have_content("name")
    #expect(all(".class")[1]).to have_content("name")
    #expect(all(".class")[2]).to have_content("name")
end
