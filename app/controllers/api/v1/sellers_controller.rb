class Api::V1::SellersController < ActionController::API
    rescue_from StandardError, with: :error_500
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActionController::ParameterMissing, with: :error_400
    before_action :authenticate_request
    before_action :doorkeeper_authorize!

    def index
        @sellers=Seller.all
        render json: {sellers: @sellers},status: :ok
    end

    def new 
        @seller=Seller.new
        render json: {seller: @seller}
    end

    def create
        @seller=Seller.new(seller_params)
        if @seller.save
            render json: {seller: @seller}
        else
            render json: {message: "seller not created"}
        end

    end

    def seller_products
        @sellers=Seller.all
        render json: {seller: @sellers}
    end


    def show
        @seller=Seller.find(params[:id])
        @addresses=@seller.address.all
        @seller=Seller.find(params[:id]) 
        render json: {seller: @seller,addresses:@addresses}
    end

    def total
        @gain=0
        @seller=Seller.find(params[:id])
        @products=@seller.products
        @products.each do |product|
            @orders=product.orders
            @orders.each do |order|
            @gain+=order.total
            end
        end
        
        render json: {"Total amount recieved to seller":@gain}
    end

    private
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

    def seller_params
        params.permit(:name, :email, :phone, :password)
    end
end
