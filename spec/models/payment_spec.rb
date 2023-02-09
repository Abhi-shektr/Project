require 'rails_helper'

RSpec.describe Payment, type: :model do
  
  describe "set_payment" do
    let(:user) { create(:user) }
    let(:cart) { create(:cart, user: user) }
    let(:payment) { create(:payment, user: user) }

    context "Callbacks" do
      it "sets the status to 'Paid' if it hasn't been set" do
        expect(payment.status).to eq("Paid")
      end

      # it "sets the total to the user's cart total if it hasn't been set" do
      #   expect(payment.total).to eq(user.cart.total)
      # end

      it 'belongs to a user' do
        expect(payment.user).to eq(user)
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
