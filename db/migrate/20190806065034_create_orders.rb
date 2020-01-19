class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :deliver_status, default: 0
      t.float :total_price
      t.string :receiver
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
