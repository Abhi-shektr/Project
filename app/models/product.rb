class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :seller
  has_and_belongs_to_many :carts
  has_many :order_details
  has_many :orders, through: :order_details
end
