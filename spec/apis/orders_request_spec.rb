require 'rails_helper'

RSpec.describe "Orders", type: :request do
    
    describe 'GET#index' do
        let(:user){create(:user)}
        let(:payment){create(:payment,user:user)}
        let!(:order1){create(:order,user:user,payment:payment)}

        before do
            get "/api/v1/orders", params: {id: user.id},headers:{"Authorization" => "Bearer #{"0APMhH08H7cyPivtOLa5f82B9E6fPk_pfibPCofKuHc"}" }
        end

        it 'returns a success response' do
            expect(response).to have_http_status(200)
          end
  
          it 'returns all orders of that user' do
              expect(JSON.parse(response.body).count).to eq(1)
            end
    end

    describe 'GET#order_count' do
        let(:user){create(:user)}
        let(:seller){create(:seller)}
        let(:payment){create(:payment,user:user)}
        let!(:order1){create(:order,user:user,payment:payment)}
        let!(:order2){create(:order,user:user,payment:payment)}
        let!(:product){create(:product,seller:seller)}
        let!(:order_detail1){create(:order_detail,order:order1,product:product)}
        let!(:order_detail2){create(:order_detail,order:order2,product:product)}
        let!(:product2){create(:product,seller:seller)}


        context 'When products has orders' do
            
          it 'returns count of orders for the product' do  
            get "/api/v1/orders/order_count", params: {id: product.id},headers:{"Authorization" => "Bearer #{"-0_ViFy79bgzFFIlhvxGEPlxb0g-RtdIqSzFhX0GtSw"}" }           
              expect(JSON.parse(response.body).count).to eq(2)
            end
        end

        context 'When products has no orders' do
    
            it 'returns message' do
                get "/api/v1/orders/order_count", params: {id: product2.id}
                expect(JSON.parse(response.body)["message"]).to eq("No orders")
              end
          end
    end
end