# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") } 

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      "Welcome to Active Admin Dashboard"
    end


  section "Latest products" do
    table_for Product.order("created_at desc").limit(5) do
        column :name
        column :desc
        column :price
        column :created_at
    end
    strong { link_to "View all", admin_products_path}
  end
  end
end

