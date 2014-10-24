class Business
  def initialize(result)
    build(result)
  end

  def name
    @name
  end

  private

    def build(result)
      if result.is_a?(GooglePlaces::Spot)
        @coords = { lat: result.lat, lng: result.lng }
        @name = result.name
      elsif result.is_a?(BurstStructure::Burst)
      end
    end

end