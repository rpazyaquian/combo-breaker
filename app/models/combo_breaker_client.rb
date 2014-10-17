require 'yelp'

class ComboBreakerClient

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
    results = @client.search(params[:location], { term: 'restaurant' })
    @businesses = results.businesses
    @cuisines = []
    results.businesses.each do |business|
      business.categories.each do |category|
        @cuisines << category unless @cuisines.include?(category)
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