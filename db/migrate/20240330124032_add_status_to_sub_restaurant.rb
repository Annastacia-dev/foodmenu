class AddStatusToSubRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_column :sub_restaurants, :status, :integer, default: 0
  end
end
