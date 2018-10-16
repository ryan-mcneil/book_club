class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    book = Book.find(params[:book_id])
    review = book.reviews.new(review_params)
    review.assign_user(params[:username])
    review.save
    redirect_to book_path(review.book)
  end

  private

  def review_params
    params.require(:review).permit(:title, :score, :description)
  end

end
