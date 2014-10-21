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
    # get a list of cuisines in the area
    all_cuisines = initial_search.cuisines
    # filter out cuisines that are in the blacklist
    valid_cuisines = category_filter(all_cuisines)
    # choose a random cuisine from that list
    @cuisine = valid_cuisines.sample
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
      @client.search(location, {
        term: 'restaurant',
        radius: radius,
        category: ''
        })
    end
end