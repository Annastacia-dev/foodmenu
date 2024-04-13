class AddSampleToRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :sample, :boolean, default: false
  end
end
