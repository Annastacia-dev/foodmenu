class CreateTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :templates, id: :uuid do |t|
      t.string :name
      t.string :primary_color
      t.string :secondary_color
      t.float :price

      t.timestamps
    end
  end
end
