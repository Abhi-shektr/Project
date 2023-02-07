class Api::V1::OrdersController < Api::V1::BaseController
    before_action :set_user
    before_action :set_product

    def set_user
        @user=User.find(params[:id])
    end

    def set_product
        @product=Product.find(params[:product_id])
    end

    def index
            
            orders=@user.orders.all
            render json: {Orders: orders},status: :ok             
    end

    def order_count
        
        c=0
        if @product.orders.present?
            orders=@product.orders.all
            @product.orders.each do |order|
                c+=1
            end
            render json: {Count: "#{c} orders for this product",Orders: orders}
        else
            render json: {messsage: "No orders"}
        end

    end
end
