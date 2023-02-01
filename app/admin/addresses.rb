ActiveAdmin.register Address do
  config.clear_action_items!
  actions :all, except: [:edit, :destroy]
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :addressable_type, :addressable_id, :house, :street, :city, :state
  #
  # or
  #
  # permit_params do
  #   permitted = [:addressable_type, :addressable_id, :house, :street, :city, :state]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
