class CreateLayouts < ActiveRecord::Migration[7.1]
  def change
    create_table :layouts, id: :uuid do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
