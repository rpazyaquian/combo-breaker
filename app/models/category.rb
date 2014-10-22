class Category < ActiveRecord::Base
  has_and_belongs_to_many :locations
  validates :display_name, uniqueness: true, presence: true
  validates :search_value, uniqueness: true, presence: true

  def self.all_categories
    Category.all.map do |category|
      category.full_name
    end
  end

  def full_name
    [self.display_name, self.search_value]
  end
end
