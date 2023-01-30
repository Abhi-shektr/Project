class RenameAddressColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :addresses, :address_type, :addressable_type
  end
end
