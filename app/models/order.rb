class Order < ApplicationRecord
  belongs_to :user
  belongs_to :payment
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  before_create :set_order

  def set_order
    @user=User.find(self.user_id)

    if @user.cart.present?
      self.total = @user.cart.total
    else
      self.total =0   
    end

  end
end
