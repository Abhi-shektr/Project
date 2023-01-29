class Payment < ApplicationRecord
  belongs_to :user
  has_one :order
  PAYMENT_LIST=["Upi","Card","Net Banking"]
end
