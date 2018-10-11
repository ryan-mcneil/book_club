class Review < ApplicationRecord
  validates_presence_of :title, :description, :score
  belongs_to :user
  belongs_to :book

  def self.top_reviews
    order(score: :DESC)
    .limit(3)
  end

  def self.bottom_reviews
    order(score: :ASC)
    .limit(3)
  end

  #caluculate books average review here
end
