require 'rails_helper'

RSpec.describe "Carts", type: :request do
    describe '#insert' do
        let(:user) { create(:user) }
        let!(:cart) { create(:cart,user: user) }
        let(:seller) { create(:seller) }
        let!(:product1) { create(:product, price: 10, req_quantity: 2,seller: seller) }
        let!(:product2) { create(:product, price: 5, req_quantity: 3,seller: seller) }

        before do
            cart.products << product1
        end

        context 'when user\'s cart is present' do
            context 'when product is already present in cart' do

                it 'should increase the quantity' do
                    post "/api/v1/carts/insert",params: {user_id: user.id,product_id: product1.id}
                    debugger
                    expect(JSON.parse(response.body)["product"]["req_quantity"]).to eq(3)
                end
            end

            # context 'when product is not present in cart' do
                
            #     it 'should add product to cart' do
            #         post "/api/v1/carts/insert",params: {user_id: user.id,product_id: product2.id}
            #         expect(JSON.parse(response.body)["product"]).to include(product2.as_json.stringify_keys)
            #     end
            # end
        end

        context 'when user\'s cart is not present' do
            
        end

        # it "redirects to the products index page" do
        #     post "/api/v1/carts/insert", params: { user_id: user.id, product_id: product1.id }
        #     expect(response).to redirect_to(products_path)
        #   end
    end
end