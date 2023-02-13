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
    
      describe "POST #create" do

        let(:seller) { create(:seller) }

        context "with valid params" do

          it "creates a new seller" do
            expect {
              post :create, params: { seller:{name: "name",email: "sel1@gmail.com", phone: 9623810735, password:"pass123"}}
            }.to change(Seller, :count).by(1)
          end
    
          it "redirects to the root path" do
            post :create, params: { seller:{name: "name",email: "sel2@gmail.com", phone: 9536154095,password:"pass123"}}
            expect(response).to redirect_to(root_path)
          end
        end
    
        context "with invalid params" do
            
          it "does not create a new seller" do
            expect {
              post :create, params: { seller: { name: nil } }
            }.to_not change(Seller, :count)
          end
    
          it "re-renders the new template" do
            post :create, params: { seller: { name: nil } }
            expect(response).to render_template("new")
          end
        end
      end
    
      describe "GET #show" do
        let(:seller) { create(:seller) }
        let(:address) { create(:address, addressable: seller) }

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