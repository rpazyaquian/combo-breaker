class CreateCategoriesLocations < ActiveRecord::Migration
  def change
    create_table :categories_locations do |t|
      t.belongs_to :location, index: true
      t.belongs_to :category, index: true
    end
  end
end
