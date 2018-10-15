class User < ApplicationRecord
  validates_presence_of :name

  has_many :reviews
  has_many :books, through: :reviews

  def self.most_active
    select("users.*, COUNT(reviews) AS review_count")
      .joins(:reviews)
      .group(:user_id, :id)
      .order("review_count DESC")
      .limit(3)
  end

  def sort_reviews_by(dir)
    if dir
      reviews.order("updated_at #{dir}")
    else
      reviews
    end
  end

end
