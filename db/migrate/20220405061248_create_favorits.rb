class CreateFavorits < ActiveRecord::Migration[6.1]
  def change
    create_table :favorits do |t|
      t.integer:user_id, null: false
      t.integer:post_location_id, null: false

      t.timestamps
    end
  end
end
