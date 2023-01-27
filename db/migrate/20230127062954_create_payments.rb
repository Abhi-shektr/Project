class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.decimal :total
      t.string :payment_mode
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
