class Api::V1::ProductsController < ActionController::API
    rescue_from StandardError, with: :error_500
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActionController::ParameterMissing, with: :error_400
    before_action :authenticate_request
    before_action :doorkeeper_authorize!
    
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
            else
                render json: {message: "Add address before adding product"}
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
        params.permit(:name, :desc, :price, :quantity, :image, :req_quantity)
    end

    def authenticate_request
        bearer_token=request.headers["Authorization"]
        render json:{message:"Authorization token is missing"},status: :unauthorized unless bearer_token.present?
    end

    def error_404(error)
        render json: {message:error.message}, status: :not_found
    end

    def error_400(error)
        render json: {message:error.message}, status: :bad_request
    end

    def error_500(error)
        render json: {message:error.message}, status: :internal_server_error
    end
end
