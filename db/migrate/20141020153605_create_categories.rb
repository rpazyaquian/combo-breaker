class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :display_name
      t.string :search_value

      t.timestamps null: false
    end
  end
end
