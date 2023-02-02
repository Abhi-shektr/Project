ActiveAdmin.register Address do
  permit_params :id, :addressable_type, :addressable_id, :house, :street, :city, :state 
  config.clear_action_items!
  actions :all, except: [:edit, :destroy]
  scope :all
  scope :user, :default => true do |address|
    Address.user
  end

  scope :user, :default => true do |address|
    Address.user
  end
  scope :seller, :default => true do |address|
    Address.seller
  end
  

  filter :id
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
