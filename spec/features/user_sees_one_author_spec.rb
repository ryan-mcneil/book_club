require 'rails_helper'

describe "user sees one author" do
  describe "they link from the books index" do

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
        score: 2,
        book: @book_2)
      @user_2.reviews.create(
        title: "What's a book?",
        description: "That was a book!",
        score: 4,
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
      @author_1.book_authors.create(book: @book_2)
      @author_1.book_authors.create(book: @book_3)
      @author_2 = Author.create(name: "Author 2")
      @author_2.book_authors.create(book: @book_2)
      @author_3 = Author.create(name: "Author 3")
      @author_3.book_authors.create(book: @book_3)
    end

    it "displays information for one author" do

      visit author_path(@author_1)

      # click_link article.title

      expect(page).to have_content("Author: #{@author_1.name}")
      # expect(page).to have_content(article.body)

    end

    it "displays the author\'s books" do

      visit author_path(@author_1)

      within "#books" do
        within "#book-#{@book_1.id}" do
          expect(page).to have_content(@book_1.title)
          expect(page).to have_content("Pages: #{@book_1.pages}")
        end
        within "#book-#{@book_2.id}" do
          expect(page).to have_content(@book_2.title)
          expect(page).to have_content("Other Authors: #{@author_2.name}")
        end
        within "#book-#{@book_3.id}" do
          expect(page).to have_content(@book_3.title)
        end
      end
    end

    it "displays a top review for each book" do

      visit author_path(@author_1)

      within "#books" do
        within "#book-#{@book_1.id}" do
          expect(page).to have_content("Wonderful")
          expect(page).to have_content("Score: 4/5")
          expect(page).to have_content("-User 1")
        end
        within "#book-#{@book_2.id}" do
          expect(page).to have_content("What's a book?")
        end
        within "#book-#{@book_3.id}" do
          expect(page).to have_content("Amazing")
        end
      end

    end

    it 'should link from index page' do

      visit books_path

      within "#book-#{@book_1.id}" do
        click_link "#{@author_1.name}"
      end

      expect(current_path).to eq(author_path(@author_1))
    end

  end

end
