class Payment < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy
  # after_create :set_payment
  after_save :save_payment
 
  # def set_payment
  #   self.status ||=" Upi"
  #   self.status ||=" Not Paid"
  #   self.total ||=0
  # end

  def save_payment
    @user=User.find(self.user_id)
    self.status ="Paid"
    self.total =@user.cart.total
  end


end
