ActiveAdmin.register OrderDetail do
  config.clear_action_items!
  actions :all, except: [:edit, :destroy]
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :quantity, :order_id, :product_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:quantity, :order_id, :product_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
