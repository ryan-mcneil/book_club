class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year

  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :users, through: :reviews
  has_many :reviews

  def average_rating
    reviews.average(:score)
  end
  
  def self.sort_by(sort, dir)
    if sort == "avg_rating"
      select("books.*, avg(score) AS avg_score")
        .joins(:reviews)
        .group(:book_id, :id)
        .order("avg_score #{dir}")
    elsif sort == "num_pages"
      all.order("pages #{dir}")
    elsif sort == "num_reviews"
      all.select("books.*, COUNT(reviews) AS review_count")
        .joins(:reviews)
        .group(:book_id, :id)
        .order("review_count #{dir}")
    else
      all
    end
  end
  
end