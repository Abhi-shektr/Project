class Seller < ApplicationRecord
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :products, dependent: :destroy
    has_many :address, as: :addressable, dependent: :destroy
    
    validates :name, presence: true
    validates_format_of :name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
    validates :phone,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 10, :maximum => 15 }
end
