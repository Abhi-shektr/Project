class RemoveAddressFromSeller < ActiveRecord::Migration[7.0]
  def change
    remove_column :sellers, :address
  end
end
