class AddAlcoholicToMenuItem < ActiveRecord::Migration[7.1]
  def change
    add_column :menu_items, :alcoholic, :boolean, default: false
  end
end
