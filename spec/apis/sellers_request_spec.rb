require 'rails_helper'

RSpec.describe "Sellers", type: :request do
    # describe "GET #new" do
    #     let!(:seller) { Seller.new }
    #     before{get api_v1_sellers_path}
    #     it "assigns a new seller to sellers" do
    #       expect(JSON.parse(response.body)).to include(seller.as_json.stringify_keys)
    #     end
    
    #     it "renders the new template" do
    #       expect(response).to have_http_status(:ok)
    #     end
    #   end
    
      describe "POST #create" do

        let(:seller) { create(:seller) }

        context "with valid params" do

          it "creates a new seller" do
            expect {
              post '/api/v1/sellers', params: {name: "name",email: "sel1@gmail.com", phone: 9623810735, password:"pass123"}
            }.to change(Seller, :count).by(1)
          end
    
        end
    
        context "with invalid params" do
            
          it "does not create a new seller" do
            expect {
              post '/api/v1/sellers', params: {name: nil } 
            }.to_not change(Seller, :count)
          end
    
          it "re-renders the new template" do
            post '/api/v1/sellers', params: { name: nil,email: "sel1@gmail.com" } 
            expect(response).to have_http_status(200)
          end
        end
      end
    
      describe "GET #show" do
        let(:seller) { create(:seller) }
        let(:address) { create(:address, addressable: seller) }

        it "assigns the requested seller to @seller" do
          get api_v1_seller_path(seller), params: { id: seller.id }
          expect(assigns(:seller)).to eq(Seller.last)
        end
    
        it "assigns the current seller's addresses to @addresses" do
          
          get api_v1_seller_path(seller), params: { id: seller.id }
          expect(assigns(:address)).to eq(Address.last)
        end
    
        it "renders the show template" do
          get api_v1_seller_path(seller), params: { id: seller.id }
          expect(response).to have_http_status(:ok)
        end
      end

end