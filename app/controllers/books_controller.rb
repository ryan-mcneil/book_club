class BooksController < ApplicationController

  def index
    @books = Book.sort_by(params[:sort], params[:dir])
    @highest_rated = Book.highest_rated
    @lowest_rated = Book.lowest_rated
    @most_active = User.most_active
  end

  def show
   @book = Book.find(params[:id])
   @top_three_reviews = @book.reviews.top_reviews
   @bottom_three_reviews = @book.reviews.bottom_reviews
   #top reviews reference the book.reviews.top whatever
  end

  def new
    @book = Book.new
  end

  def create
    require'pry';binding.pry
    #it wants strong params
    @book = Book.new(book_params)
    @book.save
    redirect_to book_path(@book)
  end


  private

  def book_params
    params.require(:book).permit(:title, :year, :pages, :authors)
  end

end
