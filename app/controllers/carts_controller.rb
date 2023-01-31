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
            @cart=@user.create_cart(user_id: params[:user_id])
            @user.cart.products << @product
            flash[:notice] = "Item added"
        
        end
        
        redirect_to products_path
    end

    def show
        if seller_signed_in?
            @seller=Seller.find(params[:id])
        elsif user_signed_in?
            @user=current_user
            if @user.cart.present?
                @cart=current_user.cart
                @qty=Hash.new()
                @cart.products.each do |p|
                    @qty.store(p.id,1)
                end 
            session[:qty]=@qty
            @total=0
                @cart=@user.cart
                @products=@cart.products
                @products.each do |p|
                    @total+=p.price
                end
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
