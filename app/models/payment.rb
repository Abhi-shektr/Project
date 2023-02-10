class Payment < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy

  after_create :set_payment

  def set_payment
    @user=User.find(self.user_id)
    self.status ="Paid"
    if @user.cart
      self.total =self.total || @user.cart.total 
    else
      self.total =0
    end

  end


end
