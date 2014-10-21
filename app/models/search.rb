class Search

  def initalize(search_params, last_cuisine)
    @client = ComboBreakerClient.new
    @last_cuisine = last_cuisine
    @search_params = search_params
  end

  def search(params, category)
    search_location = params[:location]
    search_radius = params[:radius]
    # get all the businesses in the area
    initial_search = search_client(search_location, search_radius)
    # get a list of filtered cuisines in the area
    cuisines = cuisine_filter(initial_search[:categories])
    # choose a random cuisine from that list
    @cuisine = cuisines.sample
    # repeat search looking for that specific cuisine
    cuisine_search = search_client(search_location, search_radius, @cuisine)
    # return the businesses, the cuisine, and the location.
    @businesses = cuisine_search.businesses
    @location = cuisine_search.location
  end

  private

    def last_cuisine
      @last_cuisine
    end

    def search_client(location, radius, category = '')
      results = @client.search(location, {
        term: 'restaurant',
        radius: radius,
        category: ''
        })

      {
        location: results.region,
        businesses: results.businesses,
        categories: get_categories(results.businesses)
      }
    end

    def get_categories(businesses)
      categories = Set.new
      businesses.each do |business|
        business.categories.each do |category|
          categories << category
        end
      end
      categories
    end

    def cuisine_filter(categories)
      # assuming categories is a set

    end
end