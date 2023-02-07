class Api::V1::PaymentsController < Api::V1::BaseController
    before_action :set_user, only: [:user_payments, :create, :]
    before_action :set_product, only: [:order_count]

    def set_user
        @user=User.find(params[:id])
    end

    def user_payments
        payments=@user.payments.all
        render json: {payments: payments}
    end

    def create
        if @user.address.present?
            products=@user.cart.products
            products.each do |p|
                if (p.quantity - p.req_quantity)<0
                    render json: {message: "not enough stock"}
                end
            end
                payment=@user.payments.new( payment_mode: "Upi")
                if payment.save
                    order=@user.orders.create(total: @user.cart.total, payment_id: payment.id)
                    products.each do |p|
                        order_details=order.order_details.create(quantity: p.req_quantity, product_id:p.id)
                        order.order_details << order_details 
                    end
                    user.cart.products.each do |p|
                        p.quantity=p.quantity - p.req_quantity
                    end
                    render json: {message:"Order placed",payment: payment.as_json,order:order.as_json,order_details:order.order_details}, status: :ok
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

end
