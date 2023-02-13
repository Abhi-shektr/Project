class Api::V1::UsersController < Api::V1::BaseController
    before_action :set_user, only: [:show,:update,:destroy]

    def set_user
        @user=User.find(params[:id])
    end


    def index
        users=User.all
        render json: {user: users}
    end

    def new
        user=User.new
        render json: {user: user}
    end

    def create
        
        user=User.new(user_params)      
        if user.save
            render json: {user: user}
        else
            render json: {message: "user not created"}
        end
    end


    def show
        addresses=@user.address.all
        render json: {user:@user,addresses:addresses}
    end

    def update
        if @user.update(user_params)
            render json: {message:"User updated",user: @user}
        else
            render json: {message: "User not updated"}
        end
        
    end


    def destroy
        @user.destroy
        render json: {message: "user deleted",user: @user}
    end

    
    private
    def user_params
        params.permit(:name, :email, :phone, :password)
    end
end
