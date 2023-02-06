class Api::V1::AddressesController < ActionController::API
    rescue_from StandardError, with: :error_500
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActionController::ParameterMissing, with: :error_400
    before_action :authenticate_request
    before_action :doorkeeper_authorize!
    
    def new
        @address=Address.new
        render json: {address: @address},status: :ok
    end

    def create
        
        if(params.has_key?(:user_id))
            @user=User.find(params[:user_id])
            @address=@user.address.create(address_params)
            render json: {address: @address}
        elsif(params.has_key?(:seller_id))
            @seller=Seller.find(params[:seller_id])
            @address=@seller.address.create(address_params)
            render json: {address: @address}
        else
            render json: {message: "Enter params correctly"}
        end
    end

    def destroy
        
        @address=Address.find(params[:id])
        @address.destroy
        if user_signed_in?
            render json: {address: @address}
        else
            render json: {address: @address}
        end
    end

    def address
        if(params.has_key?(:user_id))
            @user=User.find(params[:user_id])
            @addresses=@user.address.all
            render json: {addresses: @addresses}
        elsif(params.has_key?(:seller_id))
            @seller=Seller.find(params[:seller_id])
            @addresses=@seller.address.all
            render json: {addresses: @addresses}
        else
            render json: {message: "Enter params correctly"}
        end
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

    def address_params
        params.permit(:id,:house, :street, :city, :state)
    end
end
