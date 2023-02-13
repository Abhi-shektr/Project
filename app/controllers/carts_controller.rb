class CartsController < ApplicationController
    
    def new
        @cart=Cart.new
        @user=User.find(params[:user_id])
    end

    def insert
        
        @user=User.find(params[:user_id])
        @product=Product.find(params[:product_id])
        if @user.cart.present?
            if @user.cart.products.include?(@product)
                @product.update(req_quantity: (@product.req_quantity)+1)
            else
                @user.cart.products << @product
            end
            
        else
            @cart=@user.create_cart(user_id: params[:user_id])
            @user.cart.products << @product
        end
        flash[:notice] = "#{@product.name} added to cart(#{@product.req_quantity} piece in cart)"  
      
        redirect_to products_path
    end

    def show
        @user=User.find(params[:id])
        if @user.cart.present?
            @cart=@user.cart
            @cart.save
        end
        
    end

    def destroy
        @user=User.find(params[:id])
        @cart=Cart.find(params[:cart_id])
        @product=@cart.products.find(params[:product_id])
        @product.update(req_quantity: 1)
        @cart.products.delete(@product)
        redirect_to cart_path(@user)
    end

    private
    def cart_params
        params.require(:cart).permit(:user_id, :total)
    end
    def user_params
        params.require(:user).permit(:name, :email, :phone , :address)
    end
end
