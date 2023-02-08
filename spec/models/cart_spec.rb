require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'While creating cart' do
    let(:user){create(:user)}
    let(:cart) {create(:cart,user: user,total: nil)}

    it 'should set total to zero after creating cart' do
      expect(cart.total).to eq(0)
    end
  end
end
