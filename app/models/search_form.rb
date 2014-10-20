class SearchForm < ActiveRecord::Base
  validates :location, presence: true
  validates :cuisine, presence: true
  validates :radius_distance, presence: true
  validates :radius_units, presence: true
  validate :radius_must_be_less_than_40000_m

  def radius_must_be_less_than_40000_m
    if Unit("#{distance} #{units}").convert_to('m').scalar > 40000
      errors.add(:radius_distance, "must be less than 40000 m")
    end
  end
end
