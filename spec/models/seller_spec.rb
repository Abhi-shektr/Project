require 'rails_helper'

RSpec.describe Seller, type: :model do
  context 'While creating seller' do
    let(:seller1) {build :seller}
    let(:seller2) {build :seller,email: "selleremail"}
    let(:seller3) {build :seller,phone: -1}

    it 'should be valid seller with all attributes' do
      expect(seller1.valid?).to eq(true)
    end

    it 'should not be valid seller without valid email  ' do
      expect(seller2.valid?).to eq(false)
    end

    it 'should not be valid seller without valid phone number  ' do
      expect(seller3.valid?).to eq(false)
    end
  end
end
