class APIClient

  def initialize(api_type)
    @api_type = api_type
    if api_type == 'yelp'
      @client = Yelp::Client.new({ consumer_key: ENV["YELP_CONSUMER_KEY"],
                                  consumer_secret: ENV["YELP_CONSUMER_SECRET"],
                                  token: ENV["YELP_ACCESS_TOKEN"],
                                  token_secret: ENV["YELP_ACCESS_SECRET"]
                                })
    elsif api_type == 'places'
      @client = GooglePlaces::Client.new(ENV["GOOGLE_API_KEY"])
    end
  end

  def search(location, category)
    if @api_type == 'yelp'
      results = @client.search(location, { term: 'restaurant', radius: 40000, category_filter: category})
    elsif @api_type == 'places'
      coords = Geocoder.search(location).first.data["geometry"]["location"]
      results = @client.spots(coords["lat"], coords["lng"], keyword: category, types: ["restaurant"], exclude: "cafe")
    end
  end

end