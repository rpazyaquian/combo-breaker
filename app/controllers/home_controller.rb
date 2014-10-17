class HomeController < ApplicationController
  def index
  end

  private

    def combo_breaker
      require 'yelp'

      client = Yelp::Client.new({
        consumer_key: ENV["YELP_CONSUMER_KEY"],
        consumer_secret: ENV["YELP_CONSUMER_SECRET"],
        token: ENV["YELP_ACCESS_TOKEN"],
        token_secret: ENV["YELP_ACCESS_SECRET"]
      })

      cuisines = [:italian, :mexican, :chinese, :japanese, :indian, :pizza, :burgers]

      params = { term: 'food', category_filter: cuisines.sample.to_s }

      location = 'Coolidge Corner, Brookline, MA'

      results = client.search(location, params)
    end

end
