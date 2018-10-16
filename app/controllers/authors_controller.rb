class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

  def destroy
    author = Author.find(params[:id])

    author.books.each do |book|
      if book.authors.count == 1
        book.destroy
      end
    end

    author.destroy

    redirect_to books_path
  end


end
