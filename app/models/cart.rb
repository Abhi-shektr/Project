class Cart < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products
  after_create :set_cart

  def set_cart
    self.total ||=0
  end

end
