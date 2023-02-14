require 'rails_helper'

RSpec.describe PaymentsController do
    describe '#index' do
        let(:user1){create(:user)}
        let(:seller){create(:seller)}
        let(:payment){create(:payment,user: user1)}
        let!(:cart){create(:cart,user: user1)}
        let(:product1){create(:product,seller: seller)}
        before do
            get :index, params: {id: user1.id}  
            cart.products << product1         
        end

        it 'should assign payments' do
            expect(assigns(:payments)).to eq([payment])
        end

        it 'should assign products' do
            expect(assigns(:products)).to eq([product1])
        end
    end

    describe '#create' do
        let(:user1){create(:user)}
        let(:user2){create(:user,email: "user2@gmail.com",phone: 9543719057)}
        let(:seller){create(:seller)}
        let(:payment){create(:payment,user: user1)}
        let!(:cart){create(:cart,user: user1)}
        let!(:product1){create(:product,seller: seller)}
        let!(:product2){create(:product,quantity:0,seller: seller)}
        let!(:address){create(:address,addressable: user1)}
        

        context 'When user has address' do
            before do 
                cart.products << product1 
                cart.save      
            end

            context "when there is enough stock" do

                it "creates a new order and order details" do
                   
                    # expect{ post :create ,params: {id: user1.id}}.to change(Order, :count).by(1) 
                    expect{ post :create,params: {id: user1.id}}.to change(OrderDetail, :count).by(1)
                    expect(response).to redirect_to orders_path
                end
            end

            context "when there is not enough stock" do
                before do
                    cart.products << product2
                    cart.save 
                end

                it "displays a message" do
                    post :create,params: {id: user1.id}
                    expect(flash[:alert]).to eq "#{product1.name} is out of stock"
                    expect(response).to  redirect_to cart_path(user1)
                  end
            end
        end

        context "when the user does not have an address" do
            it "displays a message" do
              post :create,params:{id:user2.id}
              expect(flash[:alert]).to eq "Add address to continue"
              expect(response).to redirect_to user_path(user2)
            end
          end
    end
end