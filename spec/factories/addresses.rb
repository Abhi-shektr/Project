FactoryBot.define do
  factory :address do
    house {"Johns house"}
    street {"Edapally"}
    city {"Kochi"}
    state {"Kerala"} 
    addressable { [create(:user), create(:seller)].sample }
  end
end
