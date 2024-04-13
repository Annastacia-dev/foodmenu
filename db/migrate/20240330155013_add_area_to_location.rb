class AddAreaToLocation < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :area, :string, null: false
  end
end
