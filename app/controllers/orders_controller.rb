class OrdersController < ApplicationController
    def index
        if user_signed_in?
            @user=current_user
            @orders=@user.orders.all
            @cart=@user.cart
            # @cart.total=0
            # @cart.products.each do |p|
            #     @cart.total=@cart.total+(p.price*p.req_quantity)
                
            # end
            
        else
            @seller=current_seller
        end
    end
end
