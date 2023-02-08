require 'rails_helper'

RSpec.describe Payment, type: :model do
  context 'While creating product' do
    let(:user){create(:user)}
    let(:cart) {create(:cart,user: user,total: 0)}
    let(:payment) {create(:payment,user: user)}

    it 'should set total to zero' do
      expect(payment.valid?).to eq(true)
    end
  end
end
