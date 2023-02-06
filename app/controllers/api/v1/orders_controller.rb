class Api::V1::OrdersController < ActionController::API
    rescue_from StandardError, with: :error_500
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActionController::ParameterMissing, with: :error_400
    before_action :authenticate_request
    before_action :doorkeeper_authorize!
    
    def index
            @user=User.find(params[:id])
            @orders=@user.orders.all
            render json: {Orders: @orders},status: :ok           
        
    end

    def order_count
        @product=Product.find(params[:id])
        @c=0
        if @product.orders.present?
            @orders=@product.orders.all
            @product.orders.each do |order|
                @c+=1
            end
            render json: {Count: "#{@c} orders for this product",Orders: @orders}
        else
            render json: {messsage: "No orders"}
        end

    end

    private
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
