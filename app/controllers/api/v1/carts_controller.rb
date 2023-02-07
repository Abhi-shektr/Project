class Api::V1::CartsController < Api::V1::BaseController
    before_action :set_user, only: [:show]
    before_action :set_cart, only: [:destroy]

    def set_user
        @user=User.find(params[:id])
    end

    def set_cart
        @cart=Cart.find(params[:id])
    end
    
    def index
        cart=Cart.all
        render json: {cart: cart},status: :ok
    end


    def insert
        if(params.has_key?(:user_id)&params.has_key?(:product_id))
            user=User.find(params[:user_id])
            product=Product.find(params[:product_id])
            if user.cart.present?
                user.cart.products << product
                render json: {message:"product added to cart",product: product.as_json}
                

                
            else
                cart=user.create_cart(user_id: params[:user_id],total: 0)
                user.cart.products << product
                render json: {message:"Cart is created and product is added to cart",cart: cart,product: product.as_json}
            end
        else
            render json: {message:"Enter params correctly"}
        end
    end

    def show
        if @user.cart.present?
            cart=@user.cart
            total=0
            cart.products.each do |p|
                total=total+(p.price*p.req_quantity)
            end
            cart.update(total: total)
            render json: {message:"Showing cart",cart: @user.cart,products: cart.products}
        end
    end

    def destroy
        cart=Cart.find(params[:id])
        product=cart.products.find(params[:product_id])
        cart.products.delete(product)
        render json: {messsage:"Product removed from cart",product: product}
    end

    private
    def cart_params
        params.require(:cart).permit(:user_id, :total)
    end
    
end
