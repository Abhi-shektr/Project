class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates :name, :phone, presence: true
         validates :phone, numericality: true
    has_one :cart
    has_many :payments
    has_many :orders
    has_many :address, as: :addressable

end
