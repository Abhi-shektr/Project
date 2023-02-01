class Payment < ApplicationRecord
  belongs_to :user
  has_one :order, dependent: :destroy
end
