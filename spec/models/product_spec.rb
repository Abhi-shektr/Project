require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'While creating product' do
    let(:seller){create(:seller)}
    let(:product) {create(:product,seller: seller)}
    let(:product1) {create(:product,seller: seller,price:-10)}
    let(:product2) {create(:product,seller: seller,quantity:0)}

    it 'should be valid for product with all attributes' do
      expect(product.valid?).to eq(true)
    end

    it 'should belong to  a seller' do
      expect(product.seller).to eq(seller)
    end

    it 'should have price greater than zero' do
      expect {product1.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end  
end
