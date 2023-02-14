class Address < ApplicationRecord

    belongs_to :addressable, polymorphic: true
    validates :house, :street, :city, :state, presence: true
    validates :house, length: {minimum: 2,maximum: 40}
    validates :street, :city, :state, format: {with: /\A[a-zA-z]+\z/,message: 'only letters allowed'}

    scope :user, ->{ where(:addressable_type => 'User') }
    scope :seller, -> { where(:addressable_type => 'Seller') }

    
end
