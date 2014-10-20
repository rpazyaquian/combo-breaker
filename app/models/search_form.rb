class SearchForm < ActiveRecord::Base

  validate :radius_must_be_less_than_40000_m

  validates :location, presence: true
  validates :cuisine, presence: true
  validates :radius_distance, presence: true
  validates :radius_units, presence: true

  def radius_must_be_less_than_40000_m
    unless self.radius_units.nil?
      distance = Unit("#{self.radius_distance} #{self.radius_units}").convert_to('m').scalar
      if distance > 40000
        errors.add(:radius_distance, "must be less than 40 km/25 mi")
      end
    end
  end
end
