class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :makehash

    # def makehash
    #     @qty=Hash.new(10)
    #     if user_signed_in?
    #         user=current_user
    #             if current_user.cart.present?
    #                 @cart=current_user.cart
    #                 @cart.products.each do |p|
    #                     @qty.store(p.id,1)
    #                 end 
    #             end   
    #     end
    #     session[:qty]=@qty
    # end

     protected

          def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :phone, :email, :password)}

               devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :phone, :email, :password, :current_password)}
          end
    
end
