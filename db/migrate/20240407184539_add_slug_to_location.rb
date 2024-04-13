class AddSlugToLocation < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :slug, :string
  end
end
