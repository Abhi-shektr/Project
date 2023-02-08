ActiveAdmin.register Product do
     config.clear_action_items!
     actions :all, except: [:edit, :destroy]
  
     filter :seller
     filter :name
     filter :desc
     filter :price
     filter :quantity

     index do
          selectable_column
          id_column
          column :name
          column :desc
          column :price
          column :created_at
          column :updated_at
          column :quantity
          actions
        end
  
end
