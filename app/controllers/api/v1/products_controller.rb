class Api::V1::ProductsController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :handle_error
    def index
        @products=Product.all  
        render json: {Products: @products}
    end

    def new
        @product=Product.new
        @seller=params[:seller_id]
        render json: {product: @product}
        
    end

    def create
            @seller=Seller.find(params[:seller_id])
            if @seller.address.present?
                @product=@seller.products.create(name: params[:name], desc: params[:desc],price: params[:price],quantity: params[:quantity],image: params[:image],req_quantity: 1)
                if @product.save
                    render json: {product: @product}
                else
                    render json: {message: "Product not created"}
                end
            #else
                #render json: {message: "Add address before adding product"}
            #end 
            # @total=0
            # @cart=current_user.cart
            # @product=Product.find(params[:product_id])
            # @product.update(req_quantity:(params[:product][:quantity]))
            # render json: {product: @product}

         end
     
    end
    
    def show
        @product=Product.find(params[:id])
        render json: {product: @product}
    end

    def edit
        @product=Product.find(params[:id])
    end

    def update
        @product=Product.find(params[:id])
        if @product.update(product_params)
            render json: {product: @product}
        else
            render json: {message: "Product not updated"}
        end
        
    end

    def destroy

        @product=Product.find(params[:id])
        @product.destroy
        render json: {product: @product}
    end


    private
    def product_params
        params.require(:product).permit(:name, :desc, :price, :quantity, :image, :req_quantity)
    end

    def handle_error(error)
        render json: {error:error.message}, status: :not_found
    end
end
