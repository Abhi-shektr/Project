ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :super_admin

  
  action_item :super_admin, only: :show do
    link_to "Super Admin",super_admin_admin_admin_user_path,method: :put if !admin_user.super_admin?
  end

  member_action :super_admin, method: :put do
    if current_admin_user.super_admin? 
      admin_user=AdminUser.find(params[:id])
      admin_user.update(super_admin: true)
      redirect_to admin_admin_user_path
    else
      redirect_to admin_admin_users_path,alert: "Only Super Admins can perform this operation"
    end
  end

  controller do

    def edit
      if current_admin_user.super_admin? || current_admin_user == resource 
        super
      else
        redirect_to admin_admin_users_path, alert: "Only Super Admins can delete other admin details"
      end
    end

    def destroy
      if current_admin_user.super_admin? || current_admin_user == resource
        super
      else
        redirect_to admin_admin_users_path, alert: "Only Super Admins can delete admin details"
      end
    end
  end


  index do
    selectable_column
    id_column
    column :email
    column :super_admin
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
