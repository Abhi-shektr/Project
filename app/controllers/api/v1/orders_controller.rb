class Api::V1::OrdersController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :handle_error
    
    def index
            @user=User.find(params[:id])
            @orders=@user.orders.all
            @cart=@user.cart
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
    def handle_error(error)
        render json: {error:error.message}, status: :not_found
    end
end
