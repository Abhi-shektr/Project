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
        if @user.cart.present?
            @user.cart.products << @product
            
        else
            @cart=@user.create_cart(user_id: params[:user_id],total: 0)
            @user.cart.products << @product
        end
        flash[:notice] = "Item added"
        
        redirect_to products_path
    end

    def show
        
        @user=User.find(params[:id])
        @cart=@user.cart
        @total=0
        @cart.products.each do |p|
            @total=@total+(p.price*p.req_quantity)
        end
        @cart.update(total: @total)
        # end
        
    end

    def update
          
    end

    def destroy
        @cart=Cart.find(params[:id])
        @product=@cart.products.find(params[:product_id])
        @cart.products.delete(@product)
        redirect_to cart_path(current_user)
    end

    private
    def cart_params
        params.require(:cart).permit(:user_id, :total)
    end
    def user_params
        params.require(:user).permit(:name, :email, :phone , :address)
    end
end
