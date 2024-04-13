class AddSlugToMenu < ActiveRecord::Migration[7.1]
  def change
    add_column :menus, :slug, :string
    add_column :menu_categories, :slug, :string
    add_column :menu_items, :slug, :string
    add_index :menu_items, :slug, unique: true
    add_index :menu_categories, :slug, unique: true
    add_index :menus, :slug, unique: true
  end
end
