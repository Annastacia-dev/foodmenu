class AddCurrencyToRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :currency, :string, default: 'KES'
  end
end
