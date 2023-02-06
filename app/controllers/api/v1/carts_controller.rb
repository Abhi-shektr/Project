class Api::V1::CartsController < ActionController::API
    rescue_from StandardError, with: :error_500
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActionController::ParameterMissing, with: :error_400
    before_action :authenticate_request
    before_action :doorkeeper_authorize!
    
    def index
        @cart=Cart.all
        render json: {cart: @cart},status: :ok
    end


    def insert
        if(params.has_key?(:user_id)&params.has_key?(:product_id))
            @user=User.find(params[:user_id])
            @product=Product.find(params[:product_id])
            if @user.cart.present?
                @user.cart.products << @product
                render json: {message:"product added to cart",product: @product.as_json}
                

                
            else
                @cart=@user.create_cart(user_id: params[:user_id],total: 0)
                @user.cart.products << @product
                render json: {message:"Cart is created and product is added to cart",cart: @cart,product: @product.as_json}
            end
        else
            render json: {message:"Enter params correctly"}
        end
    end

    def show
        @user=User.find(params[:id])
        if @user.cart.present?
            @cart=@user.cart
            @total=0
            @cart.products.each do |p|
                @total=@total+(p.price*p.req_quantity)
            end
            @cart.update(total: @total)
            render json: {message:"Showing cart",cart: @user.cart,products: @cart.products}
        end
    end

    def destroy
        @cart=Cart.find(params[:id])
        @product=@cart.products.find(params[:product_id])
        @cart.products.delete(@product)
        render json: {messsage:"Product removed from cart",product: @product}
    end

    private
    def cart_params
        params.require(:cart).permit(:user_id, :total)
    end

    def authenticate_request
        bearer_token=request.headers["Authorization"]
        render json:{message:"Authorization token is missing"},status: :unauthorized unless bearer_token.present?
    end

    def error_404(error)
        render json: {message:"Enter params correctly"}, status: :not_found
    end

    def error_400(error)
        render json: {message:error.message}, status: :bad_request
    end

    def error_500(error)
        render json: {message:error.message}, status: :internal_server_error
    end
    
end
