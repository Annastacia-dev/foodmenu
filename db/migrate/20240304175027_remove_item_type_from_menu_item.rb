class RemoveItemTypeFromMenuItem < ActiveRecord::Migration[7.1]
  def change
    remove_column :menu_items, :item_type, :integer, default: nil
    remove_column :menu_items, :ingredients, :jsonb, default: []
    rename_column :menu_items, :has_nuts, :contains_nuts
  end
end
