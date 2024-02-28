class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :slug, null: false
      t.boolean :confirmed, default: false
      t.integer :status, default: 0
      t.integer :restaurant_type, default: 0

      t.timestamps
    end
  end
end
