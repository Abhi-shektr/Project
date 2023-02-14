require 'rails_helper'

RSpec.describe Seller, type: :model do
  describe 'Validation testing' do
    context 'While creating seller' do
      let(:seller1) {build :seller}
      let(:seller2) {build :seller,email: "selleremail"}
      let(:seller3) {build :seller,phone: -1}
      let(:seller4) {build :seller,phone: 12345}
      let(:seller5) {build :seller,phone: "string"}

      it 'should be valid seller with all attributes' do
        expect(seller1.valid?).to eq(true)
      end

      it 'should not be valid seller without name  ' do
        seller1.name=nil
        expect(seller2.valid?).to eq(false)
      end

      it 'should not be valid seller without valid email  ' do
        expect(seller2.valid?).to eq(false)
      end

      it 'should not be valid seller without valid phone number  ' do
        expect(seller3.valid?).to eq(false)
      end

      it 'should not be valid seller, without valid phone number(cannot be negative)  ' do
        expect(seller3.valid?).to eq(false)
      end

      it 'should not be valid seller, without valid phone number(minimum 10 digits)  ' do
        expect(seller4.valid?).to eq(false)
      end

      it 'should not be valid seller, without valid phone number(only numbers) ' do
        expect(seller5.valid?).to eq(false)
      end

    end
  end
end
