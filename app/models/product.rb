class Product < ApplicationRecord
  belongs_to :profile
  has_many_attached :images
  has_many :comments

  validates :name, :category, :price, :description, presence: true
end
