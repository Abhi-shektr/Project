ActiveAdmin.register Address do
  permit_params :id, :addressable_type, :addressable_id, :house, :street, :city, :state 
  config.clear_action_items!
  actions :all, except: [:edit, :destroy]
  
  scope :all
  
  scope :user, :default => true do |address|
    Address.user
  end
  scope :seller, :default => true do |address|
    Address.seller
  end
  

  filter :id
  filter :addressable_of_User_type_name, as: :string
  filter :addressable_of_Seller_type_name, as: :string
  filter :house
  filter :street
  filter :city
  filter :state

  index do
    selectable_column
    column :id
    column :addressable_type
    column :addressable
    column :house
    column :street
    column :city
    column :state
    column :created_at
    column :updated_at
  end

  # controller do
  #   def scoped_collection
  #     end_of_association_chain.instance_exec(params,&association_chain)
  #   end
  # end
end
