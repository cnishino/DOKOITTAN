class AddStarToPostLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :post_locations, :star, :string
  end
end
