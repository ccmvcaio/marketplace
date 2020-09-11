class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :profile

  validates :final_price, presence: true
end
