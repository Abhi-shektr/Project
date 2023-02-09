require 'rails_helper'

RSpec.describe "Users", type: :request do
    describe 'GET index' do
        let(:user1) {build :user}

        it 'should get status 200' do
            get users_path 
            expect(response).to have_http_status(200)
        end
        it 'should render user list' do
            get users_path 
            response_json = JSON.parse(response.body)   
            debugger
            expect(response_json[:user]).to include(user.as_json)
        end
        
    end

    # describe "GET #show" do
    #     let(:user) { create(:user) }
    
    #     it "shows the user and addresses" do
    #       get :show, params: { id: user.id }
    
    #       expect(response).to have_http_status(200)
    #       expect(JSON.parse(response.body)["user"]).to eq(user.as_json)
    #       expect(JSON.parse(response.body)["addresses"]).to eq(user.addresses.as_json)
    #     end
    # end


end
