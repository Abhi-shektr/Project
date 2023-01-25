class CreateSellers < ActiveRecord::Migration[7.0]
  def change
    create_table :sellers do |t|
      t.string :name
      t.integer :phone
      t.string :address

      t.timestamps
    end
  end
end
