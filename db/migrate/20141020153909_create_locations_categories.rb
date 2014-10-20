class CreateLocationsCategories < ActiveRecord::Migration
  def change
    create_table :locations_categories, id: false do |t|
      t.belongs_to :location, index: true
      t.belongs_to :category, index: true
    end
  end
end
