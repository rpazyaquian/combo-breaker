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
    # @client = APIClient.new('places'), or
    # @client = APIClient.new('yelp')
  end

  def search_api(params)
    location = params[:location]
    category = params[:cuisine]
    # if there are multiple APIs...
    # if api == 'yelp'
    begin
      results = @client.search(location, { term: 'restaurant', category_filter: category })
    rescue Yelp::Error::UnavailableForLocation => e
      raise LocationNotFound, "Location not found in Yelp API."
    end
    # elsif api == 'google'
    # yada
    # elsif api == 'zagat'
    # etc
    # so make an API object
    results
  end

  def client
    @client
  end

end