class User < ApplicationRecord
  validates_presence_of :name

  has_many :reviews
  has_many :books, through: :reviews

  def self.most_active_users
    select("users.*, COUNT(reviews) AS review_count")
      .joins(:reviews)
      .group(:user_id, :id)
      .order("review_count DESC")
  end
end
