class AddShowCaloriesToMenuAndCaloriesInfoToMenuItem < ActiveRecord::Migration[7.1]
  def change
    add_column :menus, :show_calories, :boolean, default: false
    add_column :menu_items, :calories_info, :text
  end
end
