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
        all
      elsif dir == "DESC"
        all
      end
    elsif sort == "num_pages"
      if dir == "ASC"
        all.order("pages ASC")
      elsif dir == "DESC"
        all.order("pages DESC")
      end
    elsif sort == "num_reviews"
      if dir == "ASC"
        all
      elsif dir == "DESC"
        all
      end
    else
      all
    end
  end
end
