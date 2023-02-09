require 'rails_helper'

RSpec.describe SellersController do
      describe "GET #new" do

        it "assigns a new seller to @seller" do
          get :new
          expect(assigns(:seller)).to be_a_new(Seller)
        end
    
        it "renders the new template" do
          get :new
          expect(response).to render_template("new")
        end
      end
    
    #   describe "POST #create" do

    #     let(:valid_seller_params) { { seller: attributes_for(:seller) } }
    #     let(:invalid_seller_params) { { seller: { name: nil } } }
    
    #     context "with valid params" do

    #       it "creates a new seller" do
    #         expect {
    #           post :create, params: valid_seller_params
    #         }.to change(Seller, :count).by(1)
    #       end
    
    #       it "redirects to the root path" do
    #         post :create, params: valid_seller_params
    #         expect(response).to redirect_to(root_path)
    #       end
    #     end
    
    #     context "with invalid params" do
            
    #       it "does not create a new seller" do
    #         expect {
    #           post :create, params: invalid_seller_params
    #         }.to_not change(Seller, :count)
    #       end
    
    #       it "re-renders the new template" do
    #         post :create, params: invalid_seller_params
    #         expect(response).to render_template("new")
    #       end
    #     end
    #   end
    
      describe "GET #show" do
        let(:seller) { create(:seller) }
        let(:address) { create :address, addressable: user }

        it "assigns the requested seller to @seller" do
          get :show, params: { id: seller.id }
          expect(assigns(:seller)).to eq(Seller.last)
        end
    
        it "assigns the current seller's addresses to @addresses" do
          
          get :show, params: { id: seller.id }
          expect(assigns(:address)).to eq(Address.last)
        end
    
        it "renders the show template" do
          get :show, params: { id: seller.id }
          expect(response).to render_template("show")
        end
      end
end