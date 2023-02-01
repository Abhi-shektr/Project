class RenameColumninCart < ActiveRecord::Migration[7.0]
  def change
    rename_column :carts, :quantity, :total
  end
end
