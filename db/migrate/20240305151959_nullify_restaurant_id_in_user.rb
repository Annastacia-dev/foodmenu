class NullifyRestaurantIdInUser < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :restaurant_id, true
  end
end
