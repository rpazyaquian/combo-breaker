class CreateSearchForms < ActiveRecord::Migration
  def change
    create_table :search_forms do |t|
      t.string :location
      t.string :cuisine
      t.integer :radius_distance
      t.string :radius_units

      t.timestamps null: false
    end
  end
end
