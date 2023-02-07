class AddressesController < ApplicationController

    def new
        @address=Address.new

    end

    def create
        if user_signed_in?
            @user=current_user
            @address=@user.address.create(house: params[:address][:house], street: params[:address][:street],city: params[:address][:city],state: params[:address][:state])
            if @address.save
                redirect_to user_path(current_user)
            else
                flash[:alert]=@address.errors.full_messages
                
            end
        else
            @seller=current_seller
            @address=@seller.address.create(house: params[:address][:house], street: params[:address][:street],city: params[:address][:city],state: params[:address][:state])
            redirect_to seller_path(current_seller)
        end
    end

    def destroy
        @address=Address.find(params[:id])
        @address.destroy
        if user_signed_in?
            redirect_to user_path(current_user)
        else
            redirect_to seller_path(current_seller)
        end
    end
end
