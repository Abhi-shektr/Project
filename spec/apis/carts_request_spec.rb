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
                        post insert_api_v1_carts_path,params: {user_id: user.id,product_id: product1.id}
                        expect(JSON.parse(response.body)["product"]["req_quantity"]).to eq(3)
                    end
                end

                context 'when product is not present in cart' do
                    it 'should add product to cart' do
                        post insert_api_v1_carts_path,params: {user_id: user.id,product_id: product2.id}
                        expect(cart.reload.products).to include((product1))
                    end
                end
            end

            it "redirects to the products index page" do
                post insert_api_v1_carts_path, params: { user_id: user.id, product_id: product1.id }
                expect(response).to have_http_status(:ok)
            end
        end

    describe '#show'do
        let(:user) { create(:user) }
        let(:cart) { create(:cart,user: user) }
        let(:seller) { create(:seller) }
        let(:product1) { create(:product, price: 10, req_quantity: 2,seller: seller) }
        let(:product2) { create(:product, price: 5, req_quantity: 3,seller: seller) }

        before do
            cart.products << product1
            cart.products << product2
        end

        context 'when user\'s cart is present' do

            it 'should save cart and update total' do
                get api_v1_cart_path(user)
                expect(JSON.parse(response.body)['cart']['total']).to eq((product1.price * product1.req_quantity) + (product2.price * product2.req_quantity))
            end
        end
    end

    describe '#destroy' do
        let(:user) { create(:user) }
        let(:cart) { create(:cart,user: user) }
        let(:seller) { create(:seller) }
        let(:product1) { create(:product, price: 10, req_quantity: 2,seller: seller) }

        before do
            cart.products << product1
            end

        it 'should remove product from cart' do
            delete "/api/v1/carts/#{user.id}", params: { id: user.id, cart_id: cart.id, product_id: product1.id }
            expect(JSON.parse(response.body)).to_not include(product1)
        end

        it "redirects to the cart show page for the current user" do
            delete "/api/v1/carts/#{user.id}", params: { id: user.id,cart_id: cart.id, product_id: product1.id }
            expect(response).to have_http_status(:ok)
          end
    end
end