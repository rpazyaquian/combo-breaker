require 'yelp'

class ComboBreakerClient

  def initialize
    @client = Yelp::Client.new({
      consumer_key: ENV["YELP_CONSUMER_KEY"],
      consumer_secret: ENV["YELP_CONSUMER_SECRET"],
      token: ENV["YELP_ACCESS_TOKEN"],
      token_secret: ENV["YELP_ACCESS_SECRET"]
    })
  end

  def search(params)
    get_results(params[:location], cuisine_filter(params[:cuisine]))
  end

  def cuisines
    [
      :italian,
      :mexican,
      :chinese,
      :japanese,
      :indpak,
      :pizza,
      :burgers
    ]
  end

  def cuisine_filter(cuisine)
    # remove cuisine from cuisines and get a random one
    cuisines = []
    self.cuisines.each do |possible_cuisine|
      unless possible_cuisine == cuisine
        cuisines << possible_cuisine
      end
    end
    puts cuisines
    cuisines.sample
  end

  def get_results(location, cuisine)
    {
      businesses: get_businesses(location, query_params(cuisine)),
      cuisine: translate_cuisine(cuisine)
    }
  end

  def translate_cuisine(cuisine)
    translations = {
      italian: 'Italian',
      mexican: 'Mexican',
      chinese: 'Chinese',
      japanese: 'Japanese',
      indpak: 'Indian',
      pizza: 'Pizza',
      burgers: 'Burgers'
    }

    translations[cuisine]
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