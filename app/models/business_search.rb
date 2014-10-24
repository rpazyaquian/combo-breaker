require 'yelp'
require 'google_places'
require 'geocoder'

class BusinessSearch

  def initialize
    @client = APIAdapter.new(:places)
  end

  def get_businesses(params)
    results = @client.get_results(params)
    businesses = process_results(results)
  end

  def client
    @client
  end

  private

    def process_results(results)
      results.map do |result|
        Business.new(result)
      end
    end

end