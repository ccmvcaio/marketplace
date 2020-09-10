class Product < ApplicationRecord
  belongs_to :profile
  has_many_attached :images

  validates :name, :category, :price, :description, presence: true
end
