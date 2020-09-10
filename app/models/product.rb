class Product < ApplicationRecord
  belongs_to :profile

  validates :name, :category, :price, :description, presence: true
end
