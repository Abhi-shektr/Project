class CartsController < ApplicationController
    def index
        @cart=Cart.all
    end

    def new
        @cart=Cart.new
        @user=params[:user_id]
    end

    def insert
        debugger
        @user=User.find(params[:user_id])
        @product=Product.find(params[:product_id])
        req_qty=(params[:qty]).to_i
        if req_qty>@product.quantity
            flash[:notice] = "Not available"
        else
            if @user.cart.present?
                @user.cart.products << @product
            else
                @cart=@user.create_cart(user_id: params[:user_id])
            
                @user.cart.products << @product
            
            end
        end
        flash[:notice] = "Item added"
        redirect_to user_path(@user)
    end

    def show
        @cart=Cart.find(params[:id])
    end

    def create
        redirect_to mains_user_page_path        
    end

    def update
        
    end

    def delete
        puts params
        @cart=Cart.find(params[:cart_id])
        @product=Product.find(params[:product_id])
        @cart.products.delete(@product)
    end
    private
    def cart_params
        params.require(:cart).permit(:user_id)
    end
    def user_params
        params.require(:user).permit(:name, :email, :phone , :address)
    end
end
