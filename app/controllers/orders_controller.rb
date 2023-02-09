class OrdersController < ApplicationController
    def index
        if user_signed_in?
            @user=current_user
            @orders=current_user.orders.all
                    
        else
            @seller=current_seller
            @products=current_seller.products.all
            
        end
    end
end
