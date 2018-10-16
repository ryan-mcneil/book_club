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

  def assign_user(username)
    username = to_capital_case(username)
    user = User.find_or_create_by(name: username)
    self.user = user
  end

  def to_capital_case(name)
    name.downcase.split(" ")
        .map { |l| l.capitalize }
        .join(" ")
  end

end
