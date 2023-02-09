require 'rails_helper'

RSpec.describe UsersController do
  describe '#index' do
    let(:user){build :user}

    before do
      get :index 
    end
    it 'assigns @users' do
        expect(assigns(:users)).to eq([user])
    end

    it 'assigns @users' do
      expect(response).to render_template('index')
    end

  end

  describe '#new' do

    it 'assigns a new user to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end

  end

  describe '#create' do
    context 'with valid attributes' do
      let(:user){create :user}

      # it 'creates a new user' do
      #   expect {
      #     post :create, params: { user: user.id,
      #       name: user.name,
      #       email: user.email, 
      #       password: user.password }
      #     }.to change(User, :count).by(1)
      # end

      # it 'redirects to the root path' do
      #   post :create, params: { user: attributes_for(:user) }
      #   expect(response).to redirect_to root_path
      # end
    end

    context 'with invalid attributes' do
    
      it 're-renders the new template' do
        post :create, params: { user: attributes_for(:user, name: nil) }
        expect(response).to render_template :new
      end
      
    end
  end

  describe '#show' do
    let(:user) { create :user }
    let(:address) { create :address, addressable: user }
  
    it 'returns success status' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(User.last)
      expect(assigns(:address)).to eq(Address.last)
    end

  end

end
