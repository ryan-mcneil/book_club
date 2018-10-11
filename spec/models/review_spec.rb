require 'rails_helper'

describe Review, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:score) }
  end

  describe 'Relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:book)}
  end

  describe 'Statistics' do
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

     highest_review = user_1.reviews.create(
       title: "Wonderful",
       description: "That was Fantastic!",
       score: 5,
       book: @book_1)

     user_2 = User.create(name: "User 2")

     lowest_review = user_2.reviews.create(
       title: "Terrible",
       description: "That was Awful!",
       score: 1,
       book: @book_1)

     user_3 = User.create(name: "User 3")

     #save this as an instance variable, then call it down below in the block you made for it

     @second_highest_review = user_3.reviews.create(
       title: "Average",
       description: "That was Average!",
       score: 4, book: @book_1)

       user_4 = User.create(name: "User 4")

      @middle_review =  user_4.reviews.create(
         title: "Worst best book ever",
         description: "Don't read this when your husband is around",
         score: 3, book: @book_1
       )

     end

    it 'makes top three reviews' do
      expect(@book_1.reviews.top_reviews.length).to eq(3)
      # require'pry';binding.pry
      expect(@book_1.reviews.top_reviews.first.description).to eq("That was Fantastic!")
      expect(@book_1.reviews.bottom_reviews.first.description).to eq("That was Awful!")
    end

  end


  #I NEED TO WRITE A TEST FOR TOP AND BOTTOM REVIEWS
end
