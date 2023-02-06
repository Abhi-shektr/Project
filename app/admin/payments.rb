ActiveAdmin.register Payment do
  config.clear_action_items!
  actions :all, except: [:edit, :destroy]
  
  filter :user
  filter :name
  filter :total
  filter :price
  filter :quantity
end
