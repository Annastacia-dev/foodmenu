class AddLayoutIdToRestaurantAndSubRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_reference :restaurants, :layout, type: :uuid, foreign_key: true
    add_reference :sub_restaurants, :layout, type: :uuid, foreign_key: true
  end
end
