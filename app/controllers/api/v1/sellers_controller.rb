class Api::V1::SellersController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :handle_error

    def index
        @sellers=Seller.all
        render json: {seller: @seller},status: :ok
    end

    def new 
        @seller=Seller.new
        render json: {seller: @seller}
    end

    def create
        @seller=Seller.new(seller_params)
        if @seller.save
            render json: {seller: @@seller}
        else
            render json: {message: "seller not created"}
        end

    end

    def seller_products
        @sellers=Seller.all
        render json: {seller: @sellers}
    end


    def show
        @addresses=current_seller.address.all
        @seller=Seller.find(params[:id]) 
        render json: {seller: @seller,addresses:@addresses}
    end

    private
    def handle_error(error)
        render json: {error:error.message}, status: :not_found
    end
end
