class CartsController < ApplicationController
    def index
        @cart=Cart.all
    end

    def new
        @cart=Cart.new
        @user=params[:user_id]
    end

    def insert

        @user=User.find(params[:user_id])
        @product=Product.find(params[:product_id])
        req_qty=(params[:qty]).to_i
        if @user.cart.present?
            @user.cart.products << @product
            
        else
            @cart=@user.create_cart(user_id: params[:user_id])
            @user.cart.products << @product
            flash[:notice] = "Item added"
        
        end
        # if req_qty>@product.quantity
        #     flash[:notice] = "Not available"
        # else
            
        # end
        
        redirect_to products_path
    end

    def show
        if seller_signed_in?
            @seller=Seller.find(params[:id])
        elsif user_signed_in?
            @user=User.find(params[:id])
            if @user.cart.present?
                @cart=@user.cart
            end
        end
        
    end

    def create
        redirect_to mains_user_page_path        
    end

    def update
        
    end

    def destroy
        @cart=Cart.find(params[:cart_id])
        @product=@cart.products.find(params[:id])
        @cart.products.delete(@product)
        redirect_to cart_path(current_user)
    end

    private
    def cart_params
        params.require(:cart).permit(:user_id)
    end
    def user_params
        params.require(:user).permit(:name, :email, :phone , :address)
    end
end
