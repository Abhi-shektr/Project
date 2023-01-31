class ProductsController < ApplicationController
    def index
        @products=Product.all  
        session[:quantity]=params[:quantity]
    end

    def new
        @product=Product.new
        @seller=params[:seller_id]
        
    end

    def create
        
        if seller_signed_in?
            if current_seller.address.present?
                @seller=Seller.find(params[:seller_id])
                @product=@seller.products.create(name: params[:product][:name], desc: params[:product][:desc],price: params[:product][:price],quantity: params[:product][:quantity],image: params[:product][:image])
                redirect_to seller_products_seller_path(current_seller) 
            else
                flash[:alert]="Add address to continue"
                redirect_to seller_path(current_seller) 
            end 
        else
            @cart=current_user.cart
            @qty=Hash.new()
            @cart.products.each do |p|
                @qty.store(p.id,1)
            end        
            @qty.store(params[:product_id].to_i,params[:product][:quantity].to_i)
            session[:qty]=@qty
            
        end
     
    end
    
    def show
        @product=Product.find(params[:id])
    end

    def edit
        @product=Product.find(params[:id])
    end

    def update
        @product=Product.find(params[:id])
        if @product.update(product_params)
            redirect_to seller_products_seller_path(current_seller)
        else
            render 'new'
        end
        
    end

    def destroy
        @product=Product.find(params[:id])
        @product.destroy
        redirect_to seller_products_seller_path(current_seller)
    end


    private
    def product_params
        params.require(:product).permit(:name, :desc, :price, :quantity, :image)
    end
end
