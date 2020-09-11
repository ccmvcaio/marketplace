class Product < ApplicationRecord
  belongs_to :profile
  has_many_attached :images
  has_many :comments
  has_one :sale
  validates :name, :category, :price, :description, presence: true

  enum status: {available: 0, waiting_confirmation: 5, sold: 10}

end
