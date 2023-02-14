require 'rails_helper'

RSpec.describe "Orders", type: :request do

    describe 'GET#index' do

      let(:token) { instance_double('Doorkeeper::AccessToken') }

      before do
       allow_any_instance_of(Api::V1::OrdersController).to receive(:doorkeeper_authorize!).and_return(true)
      end

        let!(:user){create(:user)}  

        let(:payment){create(:payment,user:user)}
        let!(:order1){create(:order,user:user,payment:payment)}

        it 'returns a success response' do
             get "/api/v1/orders", params: {id: user.id} 
            expect(response).to have_http_status(200)
          end
  
          it 'returns all orders of that user' do
            get "/api/v1/orders", params: {id: user.id} 
              expect(JSON.parse(response.body).count).to eq(1)
            end
    end

    describe 'GET#order_count' do
        let(:token) { instance_double('Doorkeeper::AccessToken') }

        before do
          allow_any_instance_of(Api::V1::OrdersController).to receive(:doorkeeper_authorize!).and_return(true)
        end

        let!(:user){create(:user)}
        # let(:token) { generate_access_token_for(user) }
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
            get "/api/v1/orders/order_count", params: {id: product.id},headers:{"Authorization" => "Bearer #{token}" }           
              expect(JSON.parse(response.body).count).to eq(2)
            end
        end

        context 'When products has no orders' do
    
            it 'returns message:no orders' do
                get "/api/v1/orders/order_count", params: {id: product2.id}
                expect(JSON.parse(response.body)["message"]).to eq("No orders")
              end
          end
    end


    private

    # def user_access_token(user)
    #   app = Doorkeeper::Application.create(name: 'test', redirect_uri: 'http://clientsite.com')
    #   client = OAuth2::Client.new(app.uid, app.secret) do |b|
    #     b.request :url_encoded
    #     b.adapter :rack, Rails.application
    #   end
    #   token_obj = user.doorkeeper_access_token
    #   access_token ||= OAuth2::AccessToken.new(client, token_obj.token)
    # end

    # def generate_access_token_for(user)
    #   user ||= FactoryBot.create(:user)
    #   authentication = FactoryBot.create(:authentication, user: user)
    #   application = Doorkeeper::Application.create!(:name => "MyApp", :redirect_uri => "http://app.com")
    #   access_token = Doorkeeper::AccessToken.create!(:application_id => application.id, :resource_owner_id => authentication.identity.id)
    #   access_token.token
    # end
end