class ProductsController < ApplicationController
    def index
        if params[:q].present?
            @products=Product.where("name LIKE?","%#{params[:q]}%")
            if seller_signed_in?
                @sellers=Seller.all
            end
        else
            @products=Product.all
            if seller_signed_in?
                @sellers=Seller.all
            end
        end 
    end

    def new
        @product=Product.new
        @seller=params[:seller_id]
        
    end

    def create
        
        if seller_signed_in?
            if current_seller.address.present?
                @seller=current_seller
                @product=@seller.products.create(name: params[:product][:name], desc: params[:product][:desc],price: params[:product][:price],quantity: params[:product][:quantity],image: params[:product][:image],req_quantity: 1)
                if @product.save
                    
                    redirect_to seller_products_seller_path(current_seller) 
                else
                    render 'new'
                end
            else
                flash[:alert]="Add address to continue"
                redirect_to seller_path(current_seller) 
            end 
        else
            @total=0
            @cart=current_user.cart
            @product=Product.find(params[:product_id])
            @product.update(req_quantity:(params[:product][:quantity]))
            redirect_to cart_path(current_user)

        end
     
    end
    
    def show
        @product=Product.find(params[:id])
    end

    def edit
        @product=Product.find(params[:id])
    end

    def update
        debugger
        @product=Product.find(params[:id])
        if @product.update(product_params)
            redirect_to products_path
        else
            render 'new'
        end
        
    end
    

    def destroy
        @product=Product.find(params[:id])
        @product.destroy
        redirect_to seller_products_seller_path   
    end


    private
    def product_params
        params.require(:product).permit(:name, :desc, :price, :quantity, :image, :req_quantity)
    end
end
