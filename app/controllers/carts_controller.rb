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
        if @user.cart.present?
            @user.cart.product_ids=( :params[:product_id])
        else
            puts params
            @cart=Cart.create(user_id :params[:id])
            @user.cart.product_id=params[:product_id]
        
        end
        redirect_to mains_user_page_path
    end

    def create
        redirect_to mains_user_page_path        
    end

    def update
        
    end
    private
    def cart_params
        params.require(:cart).permit
    end
end
