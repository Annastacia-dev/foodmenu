class CreateMenuItems < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_items, id: :uuid do |t|
      t.string :name
      t.jsonb :ingredients, default: []
      t.string :description
      t.float :price
      t.integer :item_type, default: 0
      t.boolean :vegan, default: false
      t.boolean :gluten_free, default: false
      t.boolean :has_nuts, default: false
      t.boolean :lactose_intolerant, default: false
      t.boolean :halal, default: false
      t.references :menu_category, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
