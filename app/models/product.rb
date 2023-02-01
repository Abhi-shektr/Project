class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :seller
  has_and_belongs_to_many :carts
  has_many :order_details,dependent: :destroy
  has_many :orders, through: :order_details
  validates :name, :desc, :price, :quantity, presence: {message: "must be given"}
  validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0 }
  validates :quantity, numericality: { only_integer: true }
  
end
