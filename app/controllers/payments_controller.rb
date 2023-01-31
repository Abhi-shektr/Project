class PaymentsController < ApplicationController
    def index
        @qty=session[:qty]
        @user=current_user
        @payments=@user.payments.all
        @cart=@user.cart
        @products=@cart.products
        @total=0
        @products.each do |p|
            @total+=@qty["#{p.id}"]*p.price
        end
        
    end

    def create
        @qty=session[:qty]       
        if current_user.address.present?
            @user=current_user
            @products=@user.cart.products
            @total=0
            @products.each do |p|
                @total+=p.price
                if (p.quantity - @qty["#{p.id}"])<0
                    flash[:alert] = "not available"
                    redirect_to cart_path(current_user) and return true
                end
            end
                @payment=@user.payments.new(total: @total, payment_mode: "Upi", status: "Paid")
                if @payment.save
                    @qty=session[:qty]
                    @order=@user.orders.create(total: @total, payment_id: @payment.id)
                    @products.each do |p|
                        @order_details=@order.order_details.create(quantity: @qty["#{p.id}"], product_id:p.id)
                        @order.order_details << @order_details 
                    end
                    current_user.cart.products.each do |p|
                        @qty=session[:qty]
                        @product=Product.find(p.id)
                        @seller=@product.seller
                        @updated_stock=@product.quantity - @qty["#{@product.id}"]
                        @product.update(quantity: @updated_stock)
                    end
                    redirect_to orders_path
                else
                    render cart_path(current_user)
                end
            
        else
            flash[:alert] = "Add address to continue"
            redirect_to user_path(current_user)
            
        end

    end

    private
    def payment_params
        params.require(:payment).permit(:user_id, :total, :mode, :status)
    end
end