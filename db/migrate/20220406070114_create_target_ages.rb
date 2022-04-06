class CreateTargetAges < ActiveRecord::Migration[6.1]
  def change
    create_table :target_ages do |t|

      t.string :target_age, null: false
      t.timestamps
    end
  end
end
