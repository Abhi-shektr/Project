class Payment < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy

  before_create :set_payment

  def set_payment
    @user=User.find(self.user_id)
    self.status ||="Paid"
    self.total ||=@user.cart.total if @user.cart
  end


end
