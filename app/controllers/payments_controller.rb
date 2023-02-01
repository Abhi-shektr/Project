class PaymentsController < ApplicationController
    def index
        @user=current_user
        @payments=@user.payments.all
        @cart=@user.cart
        @products=@cart.products
        @cart.total=0
        @cart.products.each do |p|
            @cart.total=@cart.total+(p.price*p.req_quantity)
        end
        
        
    end

    def create
        puts current_user.cart.total       
        if current_user.address.present?
            @user=current_user
            @products=@user.cart.products
            @products.each do |p|
                if (p.quantity - p.req_quantity)<0
                    if p.quantity<=0
                        flash[:alert] = "#{p.name} is out of stock"
                    else
                        flash[:alert] = "Only #{p.quantity} piece left for #{p.name}"
                    end
                    redirect_to cart_path(current_user) and return true
                end
            end
                @payment=@user.payments.new(total: 0, payment_mode: "Upi", status: "Paid")
                if @payment.save
                    @order=@user.orders.create(total: @user.cart.total, payment_id: @payment.id)
                    @products.each do |p|
                        @order_details=@order.order_details.create(quantity: p.req_quantity, product_id:p.id)
                        @order.order_details << @order_details 
                    end
                    current_user.cart.products.each do |p|
                        p.quantity=p.quantity - p.req_quantity
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