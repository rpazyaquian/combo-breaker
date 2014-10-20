module HomeHelper

    def get_categories(businesses)
      all_categories = Category.all_categories
      categories = Set.new
      businesses.each do |business|
        business.categories.each do |category|
          unless (blacklist_categories(category) || all_categories.include?([category[0], category[1].to_sym]))
            Category.create(
              display_name: category[0],
              search_value: category[1]
              )
          end

          categories << category unless blacklist_categories(category)
        end
      end
      categories
    end

    def blacklist_categories(category)
      blacklist = [
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
        ["Steakhouses", "steak"]
      ]
      blacklist.include?(category)
    end

    def filter_cuisines(cuisines)
      cuisines.delete_if do |cuisine|
        blacklist(cuisine)
      end
    end

    def blacklist(cuisine)
      blacklist = [
        last_cuisine.to_s
      ]
      blacklist.include?(cuisine)
    end

    def search_api(params, cuisine = '')
      combo_breaker_client = ComboBreakerClient.new
      combo_breaker_client.search(params, cuisine)
    end


end
