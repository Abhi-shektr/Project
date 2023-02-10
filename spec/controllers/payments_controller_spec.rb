require 'rails_helper'

RSpec.describe PaymentsController do
    describe '#index' do
        let!(:user1){create :user}
        let!(:seller){create :seller}
        let!(:payment){create(:payment,user: user1)}
        let!(:cart){create(:cart,user: user1)}
        let!(:product1){create(:product,seller: seller)}
        before do
            get :index, params: {id: user1.id}  
            cart.products << product1          
        end

        it 'should assign @payment' do
            expect(assigns(:payments)).to eq([payment])
        end

        it 'should assign @product' do
            expect(assigns(:products)).to eq([product1])
        end
    end

    describe '#create' do
        let!(:user1){create :user}
        let!(:seller){create :seller}
        let!(:payment){create(:payment,user: user1)}
        let!(:cart){create(:cart,user: user1)}
        let!(:product1){create(:product,seller: seller)}

        before do
            post :create, params: {id: user1.id}  
            cart.products << product1      
        end

        context 'When user has address' do
            
            context "when there is enough stock" do

                it "creates a new order and order details" do
                    user1.update(address: create(:address, addressable: user1))
                    expect {
                        post :create
                      }.to change(Order, :count).by(1)
                      expect {
                        post :create
                      }.to change(OrderDetail, :count).by(1)
                      expect(response).to redirect_to orders_path
                end
            end

            context "when there is not enough stock" do
                before do
                  product1.update(quantity: 0)
                end

                it "displays a message" do
                    post :create
                    expect(flash[:alert]).to eq "#{product.name} is out of stock"
                    expect(response).to redirect_to cart_path(user)
                  end
            end
        end

        context "when the user does not have an address" do
            it "displays a message" do
              user1.update(address: nil)
              post :create
              expect(flash[:alert]).to eq "Add address to continue"
              expect(response).to redirect_to user_path(user)
            end
          end
    end
end