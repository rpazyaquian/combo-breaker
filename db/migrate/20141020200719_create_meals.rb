class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :cuisine
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
