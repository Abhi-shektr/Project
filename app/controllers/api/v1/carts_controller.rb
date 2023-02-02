class Api::V1::CartsController < ActionController::API
rescue_from ActiveRecord::RecordNotFound, with: :handle_error
    
    def index
        @cart=Cart.all
        render json: {cart: @cart},status: :ok
    end


    def insert
        @user=User.find(params[:user_id])
        @product=Product.find(params[:product_id])
        if @user.cart.present?
            @user.cart.products << @product
            
        else
            @cart=@user.create_cart(user_id: params[:user_id],total: 0)
            @user.cart.products << @product
        end
        render json: {message:"item added to cart",product: @product.as_json}
    end

    def show
        
        @user=User.find(params[:id])
        @cart=@user.cart
        @total=0
        @cart.products.each do |p|
            @total=@total+(p.price*p.req_quantity)
        end
        @cart.update(total: @total)
        render json: {cart: @user.cart,products: @cart.products}
    end

    def destroy
        debugger
        @cart=Cart.find(params[:id])
        @product=@cart.products.find(params[:product_id])
        @cart.products.delete(@product)
        render json: {product: @product}
    end

    private
    def cart_params
        params.require(:cart).permit(:user_id, :total)
    end
    def handle_error(error)
        render json: {error:error.message}, status: :not_found
    end

    
end
