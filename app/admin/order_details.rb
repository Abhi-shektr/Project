ActiveAdmin.register OrderDetail do
  config.clear_action_items!
  actions :all, except: [:edit, :destroy]
  
  filter :product
  filter :quantity
  
end
