class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.string :title
      t.string :publisher_name
      t.string :author_name
      t.float :price
      t.string :picture
      t.integer :num_exist
      t.text :description

      t.timestamps
    end
    add_index :products, :title, unique: true
  end
end
