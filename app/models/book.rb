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
      if dir == "ASC"
        all.select("books.*, avg(score) AS avg_score")
            .joins(:reviews)
            .group(:book_id, :id)
            .order("avg_score ASC")
      elsif dir == "DESC"
        all.select("books.*, avg(score) AS avg_score")
            .joins(:reviews)
            .group(:book_id, :id)
            .order("avg_score DESC")
      end
    elsif sort == "num_pages"
      if dir == "ASC"
        all.order("pages ASC")
      elsif dir == "DESC"
        all.order("pages DESC")
      end
    elsif sort == "num_reviews"
      if dir == "ASC"
        all.select("books.*, COUNT(reviews) AS review_count")
            .joins(:reviews)
            .group(:book_id, :id)
            .order("review_count ASC")
      elsif dir == "DESC"
        all.select("books.*, COUNT(reviews) AS review_count")
            .joins(:reviews)
            .group(:book_id, :id)
            .order("review_count DESC")
      end
    else
      all
    end
  end
end
