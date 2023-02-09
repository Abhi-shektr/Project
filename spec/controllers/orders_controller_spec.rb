require 'rails_helper'

RSpec.describe OrdersController do
  let(:user) { create(:user) }
  let(:seller) { create(:seller) }

  describe 'index' do
    context 'when user is signed in' do
      before do
        sign_in user
        get :index
      end

      it 'assigns the current user to @user' do
        
        expect(assigns(:users)).to eq(assigns(user))
      end

      it 'assigns the user\'s orders to @orders' do
        expect(assigns(:orders)).to eq(user.orders.all)
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    context 'when user is not signed in' do
      before do
        sign_in seller
        get :index
      end

      it 'assigns the current seller to @seller' do
        expect(assigns(:seller)).to eq(seller)
      end

      it 'assigns the seller\'s products to @products' do
        expect(assigns(:products)).to eq(seller.products.all)
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end
  end
end
