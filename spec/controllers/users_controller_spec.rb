require 'rails_helper'

RSpec.describe UsersController do
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
      let!(:user1){create :user}

      it 'creates a new user' do
        expect {
          post :create, params: { user: {name: "name",email: "email@gmail.com", phone: 8745345891,password:"pass123" }}
        }.to change(User, :count).by(1)
  
      end

      it 'redirects to the root path' do
        post :create, params: { user: {name: "jon",email: "email1@gmail.com", phone: 92746583939 ,password:"pass123" }}
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
    
      it 'renders the new template' do
        post :create, params: { user: { name: nil} }
        expect(response).to render_template "new"
      end
      
    end
  end

  describe '#show' do
    let(:user) { create :user }
    let(:address) { create :address, addressable: user }
  
    it 'returns success status' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).eql?(user)
      expect(assigns(:addresses)).eql?(address)
    end

  end

end
