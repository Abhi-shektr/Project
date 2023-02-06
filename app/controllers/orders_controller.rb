class OrdersController < ApplicationController
    def index
        if user_signed_in?
            @user=current_user
            @orders=@user.orders.all
                    
        else
            @seller=current_seller
            @products=@seller.products.all
            
        end
    end
end
