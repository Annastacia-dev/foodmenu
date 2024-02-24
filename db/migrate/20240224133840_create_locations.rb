class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations, id: :uuid do |t|
      t.string :city
      t.string :county
      t.string :state
      t.string :country, null: false
      t.string :postal_code
      t.string :nearest_landmark, null: false
      t.string :building_name
      t.string :floor_number
      t.string :extra_directions
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :status, default: 0
      t.references :locatable, polymorphic: true, type: :uuid, index: true


      t.timestamps
    end
  end
end
