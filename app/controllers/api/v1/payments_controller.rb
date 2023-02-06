class Api::V1::PaymentsController < ActionController::API
    rescue_from StandardError, with: :error_500
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActionController::ParameterMissing, with: :error_400
    before_action :authenticate_request
    before_action :doorkeeper_authorize!

    def user_payments
        @user=User.find(params[:id])
        @payments=@user.payments.all
        render json: {payments: @payments}
    end

    def create
        @user=User.find(params[:id])
        if @user.address.present?
            @products=@user.cart.products
            @products.each do |p|
                if (p.quantity - p.req_quantity)<0
                    render json: {message: "not enough stock"}
                end
            end
                @payment=@user.payments.new(total: 0, payment_mode: "Upi", status: "Paid")
                if @payment.save
                    @order=@user.orders.create(total: @user.cart.total, payment_id: @payment.id)
                    @products.each do |p|
                        @order_details=@order.order_details.create(quantity: p.req_quantity, product_id:p.id)
                        @order.order_details << @order_details 
                    end
                    @user.cart.products.each do |p|
                        p.quantity=p.quantity - p.req_quantity
                    end
                    render json: {message:"Order placed",payment: @payment.as_json,order:@order.as_json,order_details:@order.order_details}, status: :ok
                else
                    render json: {message: "Order not placed"}
                end    
        else
            render json: {message: "Add address first"}
            
        end

    end

    private
    def payment_params
        params.require(:payment).permit(:user_id, :total, :mode, :status)
    end
    
    def handle_error(error)
        render json: {message:error.message}, status: :not_found
    end
end
