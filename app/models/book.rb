class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year

  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :users, through: :reviews
  has_many :reviews

  def average_rating
    reviews.average(:score).round(1)
  end

  def self.sort_by(sort, dir = "ASC")
    if sort == "avg_rating"
      if dir == "ASC"
        Book.all

      elsif dir == "DESC"
        Book.all
      end
    elsif sort == "num_pages"
      if dir == "ASC"
        Book.all
      elsif dir == "DESC"
        Book.all
      end
    elsif sort == "num_reviews"
      if dir == "ASC"
        Book.all
      elsif dir == "DESC"
        Book.all
      end
    else
      Book.all
    end
  end
end
