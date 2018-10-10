class Review < ApplicationRecord
  validates_presence_of :title, :description, :score
  belongs_to :user
  belongs_to :book
end
