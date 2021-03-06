require 'rails_helper'

describe 'user sees one user' do
  describe 'they link from another page' do

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

      @book_2 = Book.create(
        title: "Book 2",
        pages: 300,
        year: 1960)
      @review_2 = @user_1.reviews.create(
        title: "Average",
        description: "That was Average!",
        score: 2,
        book: @book_2)


      @book_3 = Book.create(
        title: "Book 3",
        pages: 100,
        year: 1980)
      @review_3 = @user_1.reviews.create(
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

    it 'should display all info for the user' do

      visit user_path(@user_1)

      expect(page).to have_content(@user_1.name)

    end

    it 'should display all reviews' do

      visit user_path(@user_1)

      within "#reviews" do

        within "#review-#{@review_1.id}" do
          expect(page).to have_content(@review_1.title)
          expect(page).to have_content("Score: #{@review_1.score}/5")
          expect(page).to have_content(@review_1.description)
        end
        within "#review-#{@review_2.id}" do
          expect(page).to have_content(@review_2.title)
        end
        within "#review-#{@review_3.id}" do
          expect(page).to have_content(@review_3.title)
        end

      end
    end

    it 'should be able to sort them by date, newest first' do

      visit user_path(@user_1)

      click_on 'sort_by_updated_at_desc'

      expect(page).to have_current_path("/users/#{@user_1.id}?dir=DESC")

      within "#reviews" do
        expect(all("#review-title")[0]).to have_content(@review_3.title)
        expect(all("#review-title")[1]).to have_content(@review_2.title)
        expect(all("#review-title")[2]).to have_content(@review_1.title)
      end

    end

    it 'should be able to sort them by date, oldest first' do

      visit user_path(@user_1)

      click_on 'sort_by_updated_at_asc'

      expect(page).to have_current_path("/users/#{@user_1.id}?dir=ASC")

      within "#reviews" do
        expect(all("#review-title")[0]).to have_content(@review_1.title)
        expect(all("#review-title")[1]).to have_content(@review_2.title)
        expect(all("#review-title")[2]).to have_content(@review_3.title)
      end

    end

    it 'should link from book index page' do

      visit books_path

      within "#most-active" do
        click_link "#{@user_1.name}"
      end

      expect(current_path).to eq(user_path(@user_1))
    end

    it 'should link from book show page' do

      visit book_path(@book_1)

      within ".reviews" do
        click_link "#{@user_1.name}"
      end

      expect(current_path).to eq(user_path(@user_1))
    end

    it 'should link from author show page' do

      visit author_path(@author_1)

      within ".username" do
        click_link "#{@user_1.name}"
      end

      expect(current_path).to eq(user_path(@user_1))
    end
  end

end
