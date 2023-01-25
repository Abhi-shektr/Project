class ProductsController < ApplicationController
    def index
        @products=Product.all        
    end

    def new
        @product=Product.new
        @seller=params[:seller_id]
        
    end

    def create
        @seller=Seller.find(params[:seller_id])
        
        @product=@seller.products.create(name: params[:product][:name], desc: params[:product][:desc],price: params[:product][:price])
        
        redirect_to seller_page_sellers_path        
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
            redirect_to root_path
        else
            render 'new'
        end
    end

    def destroy
        @product=Product.find(params[:id])
        @product.destroy
        redirect_to products_path
    end


    private
    def product_params
        params.require(:product).permit(:name, :desc, :price)
    end
end
