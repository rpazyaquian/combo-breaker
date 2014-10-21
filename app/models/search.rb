class Search

  def initialize(location, meal_history)
    @client = ComboBreakerClient.new
    @meal_history = meal_history
    @location = location

    search
  end

  def businesses
    @businesses
  end

  def cuisine
    @cuisine
  end

  def location
    @location
  end

  def meal_history
    @meal_history
  end

  private

    def search
      @cuisine = random_cuisine(@meal_history)
      @businesses = get_businesses(@location, @cuisine)
    end

    def random_cuisine(meal_history)
      all_categories = Category.all
      filtered_categories = []
      all_categories.each do |category|
        filtered_categories << category.search_value unless meal_history.include?(category.search_value)
      end
      filtered_categories.sample
    end

    def get_businesses(location, cuisine)
      search_params = { location: location, cuisine: cuisine }
      @client.search_api(search_params)
      # returns a list of businesses
    end

end