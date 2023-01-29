class SellersController < ApplicationController
    def index
        @sellers=Seller.all
    end

    def new 
        @seller=Seller.new
    end

    def create
        
        @seller=Seller.new(seller_params)
        puts seller_params
        if @seller.save!
            redirect_to root_path
        else
            render 'new'
        end

    end

    def seller_products
        @sellers=Seller.all
    end

    def seller_list
        puts params
        @seller=Seller.find(params[:id])
        
    end

    def show
        @seller=Seller.find(params[:id]) 
    end
    private
    def seller_params
        params.require(:seller).permit(:name, :phone, :address)
    end
end
