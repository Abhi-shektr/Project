ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation
 
  controller do
    def update
      if current_admin_user.super_admin?
        super
      else
        redirect_to admin_root_path, notice: "Ony Super Admins can update admin details"
      end
    end

    def destroy
      if current_admin_user.super_admin?
        super
      else
        redirect_to admin_root_path, notice: "Ony Super Admins can delete admin details"
      end
    end
  end

 

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
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
