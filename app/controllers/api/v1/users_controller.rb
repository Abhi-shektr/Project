class Api::V1::UsersController < ActionController::API
    rescue_from StandardError, with: :error_500
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActionController::ParameterMissing, with: :error_400
    before_action :authenticate_request
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

    def update
        @user=User.find(params[:id])
        if @user.update(user_params)
            render json: {message:"User updated",user: @user}
        else
            render json: {message: "User not updated"}
        end
        
    end


    def destroy
        @user=User.find(params[:id])
        @user.destroy
        render json: {message: "user deleted",user: @user}
    end

    
    private
    def user_params
        params.permit(:name, :email, :phone, :password)
    end
    
    def authenticate_request
        bearer_token=request.headers["Authorization"]
        render json:{message:"Authorization token is missing"},status: :unauthorized unless bearer_token.present?
    end

    def error_404(error)
        render json: {message:error.message}, status: :not_found
    end

    def error_400(error)
        render json: {message:error.message}, status: :bad_request
    end

    def error_500(error)
        render json: {message:error.message}, status: :internal_server_error
    end
end
