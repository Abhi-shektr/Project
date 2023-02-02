class Api::V1::OrdersController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :handle_error
    
    def index
            @user=User.find(params[:id])
            @orders=@user.orders.all
            @cart=@user.cart
            render json: {Orders: @orders},status: :ok           
        
    end
    private
    def handle_error(error)
        render json: {error:error.message}, status: :not_found
    end
end
