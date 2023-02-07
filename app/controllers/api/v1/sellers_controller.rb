class Api::V1::SellersController < Api::V1::BaseController
    before_action :set_seller, only: [:show,:total]

    def set_seller
        @seller=Seller.find(params[:id])
    end

    def index
        sellers=Seller.all
        render json: {sellers: sellers},status: :ok
    end

    def new 
        seller=Seller.new
        render json: {seller: seller}
    end

    def create
        seller=Seller.new(seller_params)
        if seller.save
            render json: {seller: seller}
        else
            render json: {message: "seller not created"}
        end

    end


    def show
        addresses=@seller.address.all
        render json: {seller: @seller,addresses:addresses}
    end

    def total
        gain=0
        products=@seller.products
        products.each do |product|
            orders=product.orders
            orders.each do |order|
            gain+=order.total
            end
        end
        
        render json: {"Total amount recieved to seller":gain}
    end

    private

    def seller_params
        params.permit(:name, :email, :phone, :password)
    end
end
