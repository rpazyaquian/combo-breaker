class Search

  def initialize(search_params)
    @client = BusinessSearch.new
    @meal_history = search_params[:meal_history]
    @location = search_params[:location]

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

  def location=(location)
    @location = location
  end

  def meal_history
    @meal_history
  end

  def meal_history=(meal_history)
    @meal_history = meal_history
  end

  private

    def search
      @businesses = []
      all_categories = Category.all
      while @businesses.length == 0
        @cuisine = random_cuisine(@meal_history, all_categories)
        @businesses = get_businesses(@location, @cuisine)
      end
    end

    def random_cuisine(meal_history, all_categories)
      filtered_categories = []
      all_categories.each do |category|
        filtered_categories << category.search_value unless meal_history.include?(category.search_value)
      end
      filtered_categories.sample
    end

    def get_businesses(location, cuisine)
      search_params = { location: location, category: cuisine }
      @client.get_businesses(search_params)
    end

end