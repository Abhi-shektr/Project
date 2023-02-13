require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'Validations' do
    let(:address) { create(:address) }

    it 'is valid with valid attributes' do
      expect(address).to be_valid
    end

    it 'is not valid without a street' do
      address.street = nil
      expect(address).to_not be_valid
    end

    it 'is not valid without a city' do
      address.city = nil
      expect(address).to_not be_valid
    end

    it 'is not valid without a state' do
      address.state = nil
      expect(address).to_not be_valid
    end
  end   

  describe 'Association' do
    let(:address) { build(:address) }
    
    it 'belongs to a user or seller' do
      expect(address.addressable).to be_present
    end
  end
end
