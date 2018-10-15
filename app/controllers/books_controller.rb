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

  @book = Book.new
  @book.title = params[:book][:title]
  @book.year = params[:book][:year]
  @book.authors = params[:book][:authors]
  @book.pages = params[:book][:pages]
  @book.save
  redirect_to book_path(@book)
  end

end
