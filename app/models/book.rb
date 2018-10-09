class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year

end
