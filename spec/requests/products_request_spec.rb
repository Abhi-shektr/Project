require 'rails_helper'

RSpec.describe "Products", type: :request do
    describe "GET #index" do
        let(:seller) { create(:seller) }
        let!(:product) { create(:product,seller: seller) }
        
        it "assigns all products as @products" do
          get api_v1_products_path  
          expect(JSON.parse(response.body)['Products']).to eq([product.as_json.stringify_keys])
        end
      end
    
      describe "POST #create" do
        # context "when seller is signed in" do
        #   let!(:seller) { create(:seller,email:"s@gmail.com",phone:8765487658) }

        #   before { sign_in(seller) }
    
        #   context "with valid address" do
        #     let!(:address) { create(:address, addressable: seller) }

        #     it "creates a new product and redirects to the products index" do
        #       post :create, params: { product: { name: "pant", desc: "blue", price: 1000 , quantity: 10} }
        #       expect(response).to have_http_status(300)
        #     end
        #   end
    
        #   context "without valid address" do
        #     it "redirects to the seller's profile page with a flash alert" do
        #       post :create, params: { product: { product: { name: "", desc: "", price: 10 , quantity: 10} }}
        #       expect(response.body).to eq("Add address to continue")
        #     end
        #   end
        # end
    
        # context "when user is signed in" do
        #   let!(:user1) { create(:user,email:"users@gmail.com") }
        #   let!(:seller1) { create(:seller,email: "sellers@gmail.com") }
        #   before { sign_in(user1) }
    
        #   it "updates the product's req_quantity" do
        #     product = create(:product, seller: seller1)
        #     post :create, params: { product_id: product.id, product: { quantity: 20 } }
        #     expect(product.reload.req_quantity).to eq(20)
        #   end
    
        #   it "redirects to the user's cart" do
        #     product = create(:product, seller: seller1)
        #     post :create, params: { product_id: product.id, product: { quantity: 20 } }
        #     expect(response).to redirect_to(cart_path(user1))
        #   end
        # end
      end
end