class PaymentsController < ApplicationController
    def index
        @user=current_user
        @payments=@user.payments.all
        @cart=@user.cart
        @products=@cart.products
        @total=0
        @products.each do |p|
            @total+=p.price
        end
        
    end

    def create
        @user=current_user
        @products=@user.cart.products
        @total=0
        @products.each do |p|
            @total+=p.price
        end
        @payment=@user.payments.new(total: @total, payment_mode: "Upi", status: "Not Paid")
        if @payment.save
            @order=@user.orders.create(total: @total, payment_id: @payment.id)
            @products.each do |p|
                @order_details=@order.order_details.create(quantity: 1, product_id:p.id)
                @order.order_details << @order_details 
            end
            
            redirect_to root_path
        else
            render 'new'
        end

    end

    private
    def payment_params
        params.require(:payment).permit(:user_id, :total, :mode, :status)
    end
end