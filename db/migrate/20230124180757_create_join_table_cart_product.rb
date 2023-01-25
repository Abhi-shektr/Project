class CreateJoinTableCartProduct < ActiveRecord::Migration[7.0]
  def change
    create_table :carts_products, :id => false do |t|
      t.references :cart, :null => false
      t.references :product, :null => false
    end
  end
end
