class Api::V1::ProductsController < Api::V1::BaseController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :set_seller, only: [:create]

    def set_product
        @product=Product.find(params[:id])
    end

    def set_seller
        @seller=Seller.find(params[:id])
    end

   
    def index
        products=Product.all  
        render json: {Products: products}
    end

    def new
        product=Product.new
        render json: {product: product}
    end

    def create
            if @seller.address.present?
                product=@seller.products.create(name: params[:name], desc: params[:desc],price: params[:price],quantity: params[:quantity],image: params[:image],req_quantity: 1)
                if product.save
                    render json: {product: product}
                else
                    render json: {message: "Product not created"}
                end
            else
                render json: {message: "Add address before adding product"}
            end 
    end
    
    def show
        render json: {product: @product}
    end

    def edit
        
    end

    def update
        if @product.update(product_params)
            render json: {product: @product}
        else
            render json: {message: "Product not updated"}
        end
        
    end

    def destroy
        @product.destroy
        render json: {product: @product}
    end


    private
    def product_params
        params.permit(:name, :desc, :price, :quantity, :image, :req_quantity)
    end
end
