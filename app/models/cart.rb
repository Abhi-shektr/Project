class Cart < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products
  before_save :set_cart

  def set_cart
    self.total =0
    @user=User.find(self.user_id)
    if self.products.present?
      self.products.each do |p|
        self.total=self.total+(p.price*p.req_quantity)
      end
    end
  end

end
