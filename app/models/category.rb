class Category < ActiveRecord::Base
  has_and_belongs_to_many :locations
  validates :display_name, uniqueness: true
  validates :search_value, uniqueness: true
end
