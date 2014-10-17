require 'yelp'

class ComboBreakerClient

  class LocationNotFound < StandardError
  end

  # look at how much nicer this is!

  def initialize
    @client = Yelp::Client.new({
      consumer_key: ENV["YELP_CONSUMER_KEY"],
      consumer_secret: ENV["YELP_CONSUMER_SECRET"],
      token: ENV["YELP_ACCESS_TOKEN"],
      token_secret: ENV["YELP_ACCESS_SECRET"]
    })
  end

  def search(params)
    begin
      results = @client.search(params[:location], { term: 'restaurant', radius_filter: params[:radius_filter] })
    rescue Yelp::Error::UnavailableForLocation => e
      raise LocationNotFound, "Location not found in Yelp API."
    end
    @reject_cuisine = params[:cuisine]
    @businesses = results.businesses
    @cuisines = []
    results.businesses.each do |business|
      business.categories.each do |category|
        @cuisines << category unless (@cuisines.include?(category) || category == @reject_cuisine)
      end
    end
  end

  def cuisines
    @cuisines
  end

  def businesses
    @businesses
  end

end