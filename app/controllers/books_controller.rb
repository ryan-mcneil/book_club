class BooksController < ApplicationController
  protect_from_forgery with: :exception

  def show
   @book = Book.find(params[:id])
  end

end
