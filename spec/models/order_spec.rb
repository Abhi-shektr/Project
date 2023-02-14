require 'rails_helper'

RSpec.describe Order, type: :model do

    describe "Callbacks" do
        let(:user) { create(:user) }
        let(:payment) { create(:payment, user: user) }
        let!(:cart) { create(:cart, user: user) }
        let!(:order) { create(:order, user: user, payment:payment) }
        
        context "set_payment" do
    
          it "sets the order total" do
            expect(order.total).to eq(cart.total)
          end
        end
      end
    
    describe "Associations" do
    let(:user) { create(:user) }
    let(:payment) { create(:payment, user: user) }
    let(:order) { create(:order, user: user,payment:payment) }

      it 'belongs to a user' do
        expect(order.user).to eq(user)
      end

      it 'belongs to a order' do
        expect(order.payment).to eq(payment)
      end

    end
  
end
