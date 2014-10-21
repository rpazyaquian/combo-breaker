class SearchForm < ActiveRecord::Base

  validates :location, presence: true
  validates :cuisine, presence: true

end
