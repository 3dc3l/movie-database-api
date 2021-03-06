class CreateCasts < ActiveRecord::Migration[6.0]
  def change
    create_table :casts do |t|
      t.string :first_name, null: false
      t.string :middle_name, null: false
      t.string :last_name, null: false
      t.string :suffix, null: true
      t.string :stage_name, null: false

      t.timestamps
    end
  end
end
