class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(params(:review))
    @review.save
    redirect_to book_path(@review.book)
  end

end
