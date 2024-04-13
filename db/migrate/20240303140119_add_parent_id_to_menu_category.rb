class AddParentIdToMenuCategory < ActiveRecord::Migration[7.1]
  def change
    add_column :menu_categories, :parent_id, :uuid
  end
end
