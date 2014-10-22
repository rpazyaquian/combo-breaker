class Category < ActiveRecord::Base
  has_and_belongs_to_many :locations
  validates :display_name, uniqueness: true, presence: true
  validates :search_value, uniqueness: true, presence: true

  def self.all_categories
    Category.all.map do |category|
<<<<<<< HEAD
      [category.display_name, category.search_value.to_sym]
=======
      category.full_name
>>>>>>> google_places
    end
  end

  def full_name
    [self.display_name, self.search_value]
  end
end
