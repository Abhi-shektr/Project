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
        context "when seller is signed in" do
          let!(:seller) { create(:seller,email:"s@gmail.com",phone:8765487658) }

          before { sign_in(seller) }
    
          context "with valid address" do
            let!(:address) { create(:address, addressable: seller) }

            it "creates a new product and redirects to the products index" do
              post  "/api/v1/products", params: { id:seller.id,name: "pant", desc: "blue", price: 1000 , quantity: 10}
              expect(JSON.parse(response.body)["product"]).to include(Product.last.as_json.stringify_keys)
            end
          end
    
          context "without valid address" do
            it "redirects to the seller's profile page with a flash alert" do
              post  "/api/v1/products", params: { id:seller.id,name: "pant", desc: "blue", price: 1000 , quantity: 10}
              expect(JSON.parse(response.body)["message"]).to eq("Add address before adding product")
            end
          end
        end
      end
end