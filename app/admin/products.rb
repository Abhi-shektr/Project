ActiveAdmin.register Product do
     config.clear_action_items!
     actions :all, except: [:edit, :destroy]
  
     filter :seller
     filter :name
     filter :desc
     filter :price
     filter :quantity
  
end
