class PaymentsController < ApplicationController
    before_action :set_user, only: [:index, :create]

    def set_user
        @user=User.find(params[:id])
    end

    def index
        @payments=@user.payments.all
        @cart=@user.cart
        @products=@cart.products        
    end

    def create
        if @user.address.present?
            @cart=@user.cart
            @products=@cart.products
            @products.each do |p|
                if (p.quantity - p.req_quantity)<0
                    if p.quantity<=0
                        flash[:alert] = "#{p.name} is out of stock"
                    else
                        flash[:alert] = "Only #{p.quantity} piece left for #{p.name}"
                    end
                    redirect_to cart_path(@user) and return true
                end
            end
                @payment=@user.payments.new( payment_mode: "Upi")
                if @payment.save
                    @order=@user.orders.create(total: @user.cart.total, payment_id: @payment.id)
                    @products.each do |p|
                        @order_details=@order.order_details.create(quantity: p.req_quantity, product_id:p.id)
                        @order.order_details << @order_details 
                
                    end
                    
                    @user.cart.products.each do |p|
                        p.quantity=p.quantity - p.req_quantity
                        p.update(req_quantity:1)
                    end
                    @user.cart.destroy
                    redirect_to orders_path
                else
                    render cart_path(@user)
                end
            
        else
            flash[:alert] = "Add address to continue"
            redirect_to user_path(@user)
            
        end

    end

    private
    def payment_params
        params.require(:payment).permit(:total, :mode, :status, :user_id)
    end
end