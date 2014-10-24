class APIAdapter
  def initialize(api_code)
    @api_code = api_code
    if @api_code == :yelp
      @client = Yelp::Client.new({ consumer_key: ENV["YELP_CONSUMER_KEY"],
                                  consumer_secret: ENV["YELP_CONSUMER_SECRET"],
                                  token: ENV["YELP_ACCESS_TOKEN"],
                                  token_secret: ENV["YELP_ACCESS_SECRET"]
                                })
    elsif @api_code == :places
      @client = GooglePlaces::Client.new(ENV["GOOGLE_API_KEY"])
    end
  end

  def get_results(params)
    location = params[:location]
    category = params[:category]

    api_search(location, category)
  end

  def api_search(location, category)
    if @api_code == :yelp
      results = @client.search(location, {term: 'restaurant', radius: 40000, category_filter: category}).businesses
    elsif @api_code == :places
      coords = Geocoder.search(location).first.data["geometry"]["location"]
      @client.spots(coords["lat"], coords["lng"], keyword: category, types: "restaurant")
    end
  end
end