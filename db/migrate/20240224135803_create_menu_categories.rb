class CreateMenuCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_categories, id: :uuid do |t|
      t.string :name
      t.string :description

      t.references :menu, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
