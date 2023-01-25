class CartsController < ApplicationController
    def index
        @cart=Cart.find(params[:user_id])
    end

    def new
        @cart=Cart.new
        @user=params[:user_id]
    end

    def insert
        #debugger
        
        @user=User.find(params[:user_id])
        @product=Product.find(params[:product_id])
        if @user.cart.present?
            @user.cart.products << @product
        else
            @cart=@user.create_cart(user_id: params[:user_id])
           
            @user.cart.products << @product
        
        end
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
    private
    def cart_params
        params.require(:cart).permit(:user_id)
    end
end
