class Seller < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :products
    has_many :address, as: :addressable
    validates :name, :phone, presence: true
    validates :name, length: {minimum: 2,maximum: 40, message: 'only letters allowed'}
    validates :phone, numericality: true 
end
