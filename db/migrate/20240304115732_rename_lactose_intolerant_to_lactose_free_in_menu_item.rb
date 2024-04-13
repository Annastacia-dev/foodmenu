class RenameLactoseIntolerantToLactoseFreeInMenuItem < ActiveRecord::Migration[7.1]
  def change
    rename_column :menu_items, :lactose_intolerant, :lactose_free
  end
end
