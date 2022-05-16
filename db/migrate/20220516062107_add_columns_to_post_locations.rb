class AddColumnsToPostLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :post_locations, :latitude, :float
    add_column :post_locations, :longitude, :float
    add_column :post_locations, :address, :string
  end
end
