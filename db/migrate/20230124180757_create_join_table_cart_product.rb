class CreateJoinTableCartProduct < ActiveRecord::Migration[7.0]
  def change
    create_join_table :Carts, :Products do |t|
        t.index [:cart_id, :product_id]
        t.index [:product_id, :cart_id]
    end
  end
end
