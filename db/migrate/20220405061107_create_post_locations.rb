class CreatePostLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :post_locations do |t|

      t.integer:user_id, null: false
      t.integer:genre_id, null: false
      t.integer:prefecture_id, null: false
      t.string:facility_name, null: false
      t.integer:target_age_id, null: false
      t.text:introduction, null: false
      t.float:review, null: false
      t.boolean:is_active, null: false, default: true

      t.timestamps
    end
  end
end
