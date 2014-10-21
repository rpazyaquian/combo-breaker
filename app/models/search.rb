class Search

  def initialize(search_params, last_cuisine)
    @client = ComboBreakerClient.new
    @last_cuisine = last_cuisine
    @search_params = search_params
  end

  def search
    search_location = @search_params[:location]
    search_radius = @search_params[:radius]
    # get all the businesses in the area
    initial_search = search_client(search_location, search_radius)
    # get a list of filtered cuisines in the area
    cuisines = cuisine_filter(initial_search[:categories])
    binding.pry
    # choose a random cuisine from that list
    @cuisine = cuisines.to_a.sample
    # repeat search looking for that specific cuisine
    cuisine_search = search_client(search_location, search_radius, @cuisine[1])
    # return the businesses, the cuisine, and the location.
    @businesses = cuisine_search[:businesses]
    binding.pry
    @location = cuisine_search[:location]
  end

  def businesses
    @businesses
  end

  def cuisine
    @cuisine[0]
  end

  def location
    @location
  end

  private

    def last_cuisine
      @last_cuisine
    end

    def search_client(location, radius, category = '')
      results = @client.search(location, radius, category)

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
      categories.to_a
    end

    def cuisine_filter(categories)
      # assuming categories is an array
      all_categories = Category.all_categories
      filtered_categories = []
      categories.each do |category|
        unless blacklisted?(category) || recorded?(category, all_categories)
          Category.create(
            display_name: category[0],
            search_value: category[1]
            )
        end
        unless blacklisted?(category)
          filtered_categories << (category)
          Category.where(search_value: category[1]).first.destroy
        end
      end
      filtered_categories
    end

    def recorded?(category, all_categories)
      all_categories.include?(category)
    end

    def blacklisted?(category)
      blacklist.include?(category)
    end

    def blacklist
      blacklist = [
        [@last_cuisine.display_name, @last_cuisine.search_value],
        ['Lounges', 'lounges'],
        ['Bars', 'bars'],
        ["Fruits & Veggies", 'markets'],
        ["Salad", "salad"],
        ["Bakeries", 'bakeries'],
        ["Coffee & Tea", 'coffee'],
        ["Food Stands", 'foodstands'],
        ["Food Trucks", "foodtrucks"],
        ["Fast Food", "hotdogs"],
        ["Diners", "diners"],
        ["Breakfast & Brunch", "breakfast_brunch"],
        ["Jazz & Blues", "jazzandblues"],
        ["Venues & Event Spaces", "venues"],
        ["Delis", "delis"],
        ["Steakhouses", "steak"]
      ]
    end
end