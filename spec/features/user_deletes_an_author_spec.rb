require 'rails_helper'

describe 'user visits author\'s show page' do
  describe 'they click delete' do

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
      @author_2.book_authors.create(book: @book_2)
      @author_3 = Author.create(name: "Author 3")
      @author_3.book_authors.create(book: @book_3)
      @author_4 = Author.create(name: "Author 4")
      @author_4.book_authors.create(book: @book_3)
    end

    it 'deletes the author' do

      visit author_path(@author_1)

      click_link "Delete"

      expect(current_path).to eq(books_path)

      expect(page).to_not have_content(@author_1.name)
      expect(Author.all).to_not include(@author_1)


      within "#book-#{@book_2.id}" do
        expect(page).to have_content("Author: #{@author_2.name}")
      end

      within "#book-#{@book_3.id}" do
        expect(page).to have_content("Authors: #{@author_3.name}, #{@author_4.name}")
      end


    end

    it 'also deletes the book if book has no more authors' do

      visit author_path(@author_1)

      click_link "Delete"

      expect(current_path).to eq(books_path)

      expect(page).to_not have_css("#book-#{@book_1.id}")
      expect(page).to_not have_content(@author_1.name)
      expect(page).to_not have_content(@book_1.title)

      expect(Author.all).to_not include(@author_1)
      expect(Book.all).to_not include(@book_1)

      within "#book-#{@book_2.id}" do
        expect(page).to have_content("Author: #{@author_2.name}")
        expect(page).to have_content(@book_2.title)
      end

      within "#book-#{@book_3.id}" do
        expect(page).to have_content("Authors: #{@author_3.name}, #{@author_4.name}")
        expect(page).to have_content(@book_3.title)
      end



    end

    it 'does not delete book if it has other authors' do

      visit author_path(@author_3)

      click_link "Delete"

      expect(current_path).to eq(books_path)

      expect(page).to_not have_content(@author_3.name)

      expect(Author.all).to_not include(@author_3)
      expect(Book.all).to include(@book_3)

      within "#book-#{@book_1.id}" do
        expect(page).to have_content("Author: #{@author_1.name}")
        expect(page).to have_content(@book_1.title)
      end

      within "#book-#{@book_2.id}" do
        expect(page).to have_content("Author: #{@author_2.name}")
        expect(page).to have_content(@book_2.title)
      end

      within "#book-#{@book_3.id}" do
        expect(page).to have_content("Author: #{@author_4.name}")
        expect(page).to have_content(@book_3.title)
      end
    end
  end
end
