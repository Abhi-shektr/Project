class Payment < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy
  before_create :set_payment

  def set_payment
    @user=User.find(self.user_id)

    self.status ="Paid"
    
    if @user.cart.present?
      self.total = @user.cart.total
    else
      self.total =0   
    end

  end


end
