class Meal < ActiveRecord::Base
  belongs_to :user
  validates :cuisine, presence: true
end
