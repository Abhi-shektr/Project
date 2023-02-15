class Payment < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy
  before_create :set_payment

  def set_payment
    
    self.status ="Paid"
    
    if self.user.cart.present?
      self.total = self.user.cart.total
    else
      self.total =0   
    end

  end


end
