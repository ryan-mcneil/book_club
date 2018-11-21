class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :users, through: :reviews
  has_many :reviews, dependent: :destroy

  def average_rating
    reviews.average(:score)
  end

  def self.sort_by(sort, dir)
    if sort == "avg_rating"
      select("books.*,
        CASE WHEN count(reviews.score) = 0
          THEN 0 ELSE avg(reviews.score)
          END AS avg_score")
        .left_outer_joins(:reviews)
        .group(:book_id, :id)
        .order("avg_score #{dir}")
    elsif sort == "num_pages"
      order("pages ?", dir)
    elsif sort == "num_reviews"
      select("books.*, COUNT(reviews) AS review_count")
        .left_outer_joins(:reviews)
        .group(:book_id, :id)
        .order("review_count #{dir}")
    else
      all
    end
  end

  def self.highest_rated
    sort_by("avg_rating", "DESC").limit(3)
  end

  def self.lowest_rated
    sort_by("avg_rating", "ASC").limit(3)
  end

  def other_authors(author)
    authors - [author]
  end

  def top_reviews(n)
    reviews.order(score: :DESC).limit(n)
  end
end
