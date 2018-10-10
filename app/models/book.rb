class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year

  has_many :book_authors
end
