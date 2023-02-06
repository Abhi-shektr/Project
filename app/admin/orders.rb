ActiveAdmin.register Order do
  config.clear_action_items!
  actions :all, except: [:edit, :destroy]
  
  filter :user
  filter :products
  filter :total
  
end
