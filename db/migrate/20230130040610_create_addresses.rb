class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :address_type
      t.integer :addressable_id
      t.string :house
      t.string :street
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
