require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'Associations' do
    let(:user){build(:user)}
    let(:seller){build(:seller)}
    let(:cart) {create(:cart, user: user)}
    let(:product) {build(:product, seller: seller)}

    it 'belongs to a user' do
      expect(cart.user).to eq_to(user)
    end

    it 'has and belongs to many products' do
      cart.products << product
      expect(cart.products).to include(product)
    end
  end

  describe "Callback" do
    let(:user){build(:user)}
    let(:cart) {create(:cart, user: user)}
    context "Set cart" do
      it "sets the total to 0 " do
        expect(cart.total).to eq(0)
      end
    end
  end
end
