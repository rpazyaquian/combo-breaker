class HomeController < ApplicationController
  def index
    results = combo_breaker('Coolidge Corner, Brookline, MA')
    @businesses = results[:businesses]
    @category = results[:category]
  end

  private

    def combo_breaker(location)
      # maybe make this its own class?
      require 'yelp'

      client = Yelp::Client.new({
        consumer_key: ENV["YELP_CONSUMER_KEY"],
        consumer_secret: ENV["YELP_CONSUMER_SECRET"],
        token: ENV["YELP_ACCESS_TOKEN"],
        token_secret: ENV["YELP_ACCESS_SECRET"]
      })

      cuisines = [:italian, :mexican, :chinese, :japanese, :indian, :pizza, :burgers]

      category = cuisines.sample.to_s

      params = { term: 'food', category_filter: category }

      results = {
        businesses: client.search(location, params).businesses,
        category: category.capitalize
      }

    end

end
