require 'rails_helper'

RSpec.describe Payment, type: :model do
  
  describe "set_payment" do
    let!(:user) { create(:user) }
    let!(:cart) { create(:cart, user: user) }
    let!(:payment) { create(:payment, user: user) }

    context "Callbacks" do
      it "sets the status to 'Paid' if it hasn't been set" do
        expect(payment.status).to eq("Paid")
        expect(payment.total).to eq(cart.total)
      end
    end
  end

  describe "Associations" do
    let(:user) { create(:user) }
    let(:payment) { create(:payment, user: user) }

      it 'belongs to a user' do
        expect(payment.user).to eq(user)
      end
    end
end
