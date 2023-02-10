require 'rails_helper'

RSpec.describe CartsController do
    describe '#insert' do
        let(:user) { create(:user) }
        let(:cart) { create(:cart,user: user) }
        let(:seller) { create(:seller) }
        let(:product1) { create(:product, price: 10, req_quantity: 2,seller: seller) }
        let(:product2) { create(:product, price: 5, req_quantity: 3,seller: seller) }

        before do
            cart.products << product1
        end

        context 'when user\'s cart is present' do
            context 'when product is already present in cart' do

                it 'should increase the quantity' do
                    post :insert,params: {user_id: user.id,product_id: product1.id}
                    expect(product1.reload.req_quantity).to eq(3)
                end
            end

            context 'when product is not present in cart' do
                
                it 'should add product to cart' do
                    post :insert,params: {user_id: user.id,product_id: product2.id}
                    expect(cart.reload.products).to include((product2))
                end
            end
        end

        it "redirects to the products index page" do
            post :insert, params: { user_id: user.id, product_id: product1.id }
            expect(response).to redirect_to(products_path)
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

            it 'should calculate total' do
                get :show, params: { id: user.id }
                expect(assigns(:total)).to eq((product1.price * product1.req_quantity) + (product2.price * product2.req_quantity))
            end

            it 'should update total' do
                get :show, params: { id: user.id }
                expect(cart.reload.total).to eq((product1.price * product1.req_quantity) + (product2.price * product2.req_quantity))
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
            delete :destroy, params: { id: user.id, cart_id: cart.id, product_id: product1.id }
            expect(cart.reload.products).to_not include(product1)
        end

        it "redirects to the cart show page for the current user" do
            delete :destroy, params: { id: user.id,cart_id: cart.id, product_id: product1.id }
            expect(response).to redirect_to(cart_path(cart.user))
          end
    end


end