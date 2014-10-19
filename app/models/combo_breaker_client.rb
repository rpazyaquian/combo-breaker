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
      results = @client.search(params[:location], { term: 'restaurant', radius: params[:radius] })
    rescue Yelp::Error::UnavailableForLocation => e
      raise LocationNotFound, "Location not found in Yelp API."
    end
    results.businesses
  end


end