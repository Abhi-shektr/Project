class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :seller
  has_and_belongs_to_many :carts
  has_many :order_details
  has_many :orders, through: :order_details
  # validates :name, :desc, :price, presence: true
  # validates :name, :desc,  length: {minimum: 2,maximum: 40, message: 'only letters allowed'}
  # validates :price, numericality: true 
  
end
