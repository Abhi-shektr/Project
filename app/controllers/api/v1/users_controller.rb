class Api::V1::UsersController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :handle_error
    doorkeeper_for :all
    before_action :doorkeeper_authorize!

    def index
        @users=User.all
        render json: {user: @users},status: :ok
    end

    def new
        @user=User.new
        render json: {user: @user}
    end

    def create
        debugger
        @user=User.new(user_params)
        if @user.save
            render json: {user: @user}
        else
            render json: {message: "user not created"}
        end
    end


    def show
        @user=User.find(params[:id])
        @addresses=@user.address.all
        render json: {user:@user,addresses:@addresses}
    end

    private
    def user_params
        params.permit(:name, :email, :phone)
    end
    def handle_error(error)
        render json: {error:error.message}, status: :not_found
    end
    def current_user
        @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
      end
end
