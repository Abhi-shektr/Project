ActiveAdmin.register Product do
     config.clear_action_items!
     actions :all, except: [:edit, :destroy]
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :desc, :price, :seller_id, :quantity
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :desc, :price, :seller_id, :quantity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
