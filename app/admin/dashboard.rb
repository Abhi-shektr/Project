# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  # section "Recent Products" do
  #   table_for Product.order{"created_at desc"}.limit(5) do
  #       column :name
  #       column :created_at
  #   end
  #   strong { link_to "View all", admin_products_path}
  # end
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }
  

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
  end 
end

