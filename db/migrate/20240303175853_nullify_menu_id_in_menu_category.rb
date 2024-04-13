class NullifyMenuIdInMenuCategory < ActiveRecord::Migration[7.1]
  def change
    change_column_null :menu_categories, :menu_id, true
  end
end
