require 'rails_helper'

RSpec.describe "Payments", type: :request do
    describe '#index' do
        let!(:token) { instance_double('Doorkeeper::AccessToken') }

        before do
            allow_any_instance_of(Api::V1::PaymentsController).to receive(:doorkeeper_authorize!).and_return(true)
        end

        let(:user1){create(:user)}
        let(:seller){create(:seller)}
        let(:payment){create(:payment,user: user1)}
        let!(:cart){create(:cart,user: user1)}
        let(:product1){create(:product,seller: seller)}

        before do
            get api_v1_payments_path, params: {id: user1.id}  
            cart.products << product1         
        end

        it 'should assign payments' do
            expect(JSON.parse(response.body)["payment"]).eql?([payment])
        end

        it 'should assign products' do
            expect(JSON.parse(response.body)["products"]).eql?([product1])
        end
    end

     describe '#create' do
        let(:token) { instance_double('Doorkeeper::AccessToken') }

        before do
            allow_any_instance_of(Api::V1::PaymentsController).to receive(:doorkeeper_authorize!).and_return(true)
        end

        let(:user1){create(:user)}
        let!(:user2){create(:user,email: "user2@gmail.com",phone: 9543719057)}
        let(:seller){create(:seller)}
        let(:payment){create(:payment,user: user1)}
        let!(:cart){create(:cart,user: user1)}
        let!(:product1){create(:product,seller: seller)}
        let!(:product2){create(:product,quantity:-1,seller: seller)}
        let!(:address){create(:address,addressable: user1)}
        

        context 'When user has address' do
            before do 
                cart.products << product1 
                cart.save      
            end

            context "when there is enough stock" do

                it "creates a new order and order details" do
                    expect{ post "/api/v1/payments/" ,params: {id: user1.id}}.to change(Order, :count).by(1)
                    expect{ post "/api/v1/payments/",params: {id: user1.id}}.to change(OrderDetail, :count).by(1)
                    expect(JSON.parse(response.body)["message"]).eql?("Order placed")
                end
            end

            context "when there is not enough stock" do
                before do
                    cart.products << product2
                    cart.save 
                end

                it "displays a message" do
                    post "/api/v1/payments/",params: {id: user1.id}
                    expect(JSON.parse(response.body)["message"]).eql?("not enough stock")
                  end
            end
        end

        context "when the user does not have an address" do
            it "displays a message" do
              post "/api/v1/payments/",params:{id:user2.id}
              expect(JSON.parse(response.body)["message"]).to eq("Add address first")
            end
          end
    end
    
end