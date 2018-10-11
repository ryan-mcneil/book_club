class BooksController < ApplicationController

   def index
    @books = Book.all
   end


  def show
   @book = Book.find(params[:id])
   @top_three_reviews = @book.reviews.top_reviews
   @bottom_three_reviews = @book.reviews.bottom_reviews
   #top reviews reference the book.reviews.top whatever
  end

end
