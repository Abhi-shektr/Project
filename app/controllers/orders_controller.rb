class OrdersController < ApplicationController
    def index
        @seller=current_seller
        if user_signed_in?
            @user=current_user
            @orders=@user.orders.all
            
        else
            @seller=current_seller
        end
    end
end
