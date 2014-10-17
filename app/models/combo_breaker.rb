require 'yelp'

class ComboBreaker

  def initialize
    @client = Yelp::Client.new({
      consumer_key: ENV["YELP_CONSUMER_KEY"],
      consumer_secret: ENV["YELP_CONSUMER_SECRET"],
      token: ENV["YELP_ACCESS_TOKEN"],
      token_secret: ENV["YELP_ACCESS_SECRET"]
    })
  end

  def search(params)
    # takes a location and the last cuisine you ate
    # e.g. params = { location: 'location', cuisine: :cuisine }
    # returns the search results
    # @client.search(params[:location], cuisine_filter(params[:cuisine])
    # cuisine_filter is the params passed into the yelp search
    # that filters results down by 'food' category and a cuisine
    # different from the one supplied by the user
    # e.g. params = { term: 'food', category_filter: category }

    get_results(params[:location], cuisine_filter(params[:cuisine]))

    # which will look like, for example:
    # {
    #   businesses: [blah blah blah],
    #   cuisine: 'Italian'
    # }
    # so you can be like results = ComboBreaker.search(location)
    # and then be like results[:businesses] and results[:cuisine]
  end

  def cuisines
    [
      :italian,
      :mexican,
      :chinese,
      :japanese,
      :indian,
      :pizza,
      :burgers
    ]
  end

  def cuisine_filter(cuisine)
    # remove cuisine from cuisines and get a random one
    self.cuisines.delete(cuisine).sample
  end

  def get_results(location, cuisine)
    {
      businesses: get_businesses(location, query_params(cuisine)),
      cuisine: cuisine.to_s.capitalize
    }
  end

  def query_params(cuisine)
    {
      term: 'food',
      category_filter: cuisine
    }
  end

  def get_businesses(location, params)
    @client.search(location, params).businesses
  end

end

# example usage (for now):
# combo_breaker = ComboBreaker.new
# combo_breaker.search({
#   location: 'Coolidge Corner, Brookline, MA',
#   last_cuisine: :italian
# })
#