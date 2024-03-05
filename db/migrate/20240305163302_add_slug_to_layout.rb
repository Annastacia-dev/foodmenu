class AddSlugToLayout < ActiveRecord::Migration[7.1]
  def change
    add_column :layouts, :slug, :string
    add_index :layouts, :slug, unique: true
  end
end
