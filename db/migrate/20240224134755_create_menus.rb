class CreateMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :menus, id: :uuid do |t|
      t.string :name
      t.string :description
      t.integer :tax_behavior, default: 0
      t.references :restaurant, null: false, foreign_key: true, type: :uuid
      t.references :sub_restaurant, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
