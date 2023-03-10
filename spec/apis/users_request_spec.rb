require 'rails_helper'

RSpec.describe "Users", type: :request do
    describe 'GET #index' do
        let(:token) { instance_double('Doorkeeper::AccessToken') }

        before do
            allow_any_instance_of(Api::V1::UsersController).to receive(:doorkeeper_authorize!).and_return(true)
        end
      
        let(:user1) { create :user,email:"user1@gmail.com",phone:9368741084 }
        let(:user2) { create :user,email:"user2@gmail.com",phone:8641749360 }

        it 'returns a success response' do
          get api_v1_users_path
          expect(response).to have_http_status(200)
        end

        it 'returns all users' do
          get api_v1_users_path,headers:{"Authorization" => "my-token" }
            expect(JSON.parse(response.body)['user'].count).eql?(2)
          end
    
    end

    describe 'GET #new' do

        let(:token) { instance_double('Doorkeeper::AccessToken') }

        before do
            allow_any_instance_of(Api::V1::UsersController).to receive(:doorkeeper_authorize!).and_return(true)
        end

        let(:user3) { User.new }
    
        before {get new_api_v1_user_path }
    
        it 'returns a success response' do
          expect(response).to have_http_status(:ok)
        end
    
        it 'returns a new user' do
            expect(JSON.parse(response.body)).to include("user" => user3.as_json.stringify_keys)
        end
    end

    describe "POST #create" do

        let(:token) { instance_double('Doorkeeper::AccessToken') }

        before do
            allow_any_instance_of(Api::V1::UsersController).to receive(:doorkeeper_authorize!).and_return(true)
        end

        context "with valid parameters" do 
          it "creates a new user" do
            expect {
              post '/api/v1/users', params: {name: "name",email: "email@gmail.com", phone: 8745345891,password:"pass123" }
            }.to change(User, :count).by(1)
          end
      
          it "returns the created user as JSON" do
            post '/api/v1/users', params: {name: "jon",email: "email1@gmail.com", phone: 92746583939 ,password:"pass123" }
            expect(JSON.parse(response.body)["user"]).to include(User.last.as_json.stringify_keys)
          end
      
        end
      
        context "with invalid parameters" do
      
          before do
            post '/api/v1/users', params: { user:
                {
               name: nil,
               phone: nil,
               email: nil,
               password: nil
             }
            }
          end
      
          it "does not create a new user" do
            expect(User.count).to eq(0)
          end
      
          it "returns a error message" do
            expect(JSON.parse(response.body)).to include("message" => "user not created")
          end
      
        end
      end

      describe "GET #show" do

        let(:token) { instance_double('Doorkeeper::AccessToken') }

        before do
            allow_any_instance_of(Api::V1::UsersController).to receive(:doorkeeper_authorize!).and_return(true)
        end

        let(:user) { create(:user,email:"adam@gmail.com",phone:9735485763) }
        let!(:address){create(:address, addressable: user)}
        before do
          stub_doorkeeper_token("my-token")
          get api_v1_user_path(user) , params: {id: user.id}
        end
    
        it "returns a success response" do
            expect(response).to have_http_status(:success)
        end
    
        it "returns the user and their addresses" do
          expect(JSON.parse(response.body)['user']).to eq(user.as_json.stringify_keys)
          expect(JSON.parse(response.body)['addresses']).to eq([address.as_json.stringify_keys])
            
        end
      end
      
      
       
      describe 'DELETE #destroy' do

        let(:token) { instance_double('Doorkeeper::AccessToken') }

        before do
            allow_any_instance_of(Api::V1::UsersController).to receive(:doorkeeper_authorize!).and_return(true)
        end

        let!(:user) { create(:user) }
        it 'deletes the user' do
          expect {
            delete "/api/v1/users/#{user.id}", params: { id: user.id }}.to change(User, :count).by(-1)
        end
      
        it 'returns a JSON response with the message "user deleted" and the deleted user' do
            delete "/api/v1/users/#{user.id}"
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)["message"]).to include("user deleted")
          expect(JSON.parse(response.body)["user"]["id"]).to eq(user.id)
        end
      end
end
