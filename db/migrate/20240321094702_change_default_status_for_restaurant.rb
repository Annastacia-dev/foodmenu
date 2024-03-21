class ChangeDefaultStatusForRestaurant < ActiveRecord::Migration[7.1]
  def change
    change_column_default :restaurants, :status, from: 0, to: 1
  end
end
