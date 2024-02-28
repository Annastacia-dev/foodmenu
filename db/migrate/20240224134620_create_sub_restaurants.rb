class CreateSubRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :sub_restaurants, id: :uuid do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.string :phone_number
      t.string :email
      t.references :restaurant, null: false, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
