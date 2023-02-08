FactoryBot.define do
  factory :payment do
    total {1000}
    payment_mode {"Upi"}
    status {"Paid"}
  end
  
end
