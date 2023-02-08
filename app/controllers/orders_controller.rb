class OrdersController < ApplicationController
    def index
        if user_signed_in?
            @orders=current_user.orders.all
                    
        else
            @products=current_seller.products.all
            
        end
    end
end
