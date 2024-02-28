class AddConfirmedAtToRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :confirmed_at, :datetime
  end
end
