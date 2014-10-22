class HomeController < ApplicationController

  def index
    @cuisine_options = Category.all_categories.sort_by { |category| category[0] }
    @distance_units = [
      :mi,
      :km
    ]
    @search_form = SearchForm.new
  end

  def search
<<<<<<< HEAD
    search_form = SearchForm.new(search_form_params)

    if search_form.valid?
      # if search form is valid,
      # add the last_cuisine to the user's meals.
      # then run a search on the location for a random cuisine.
      # where does the random cuisine get determined?
      location = search_form_params[:location]
      current_user.meals.create(cuisine: last_cuisine.to_sym)
      search = Search.new(location)
      @businesses = search.businesses
      @cuisine = search.cuisine
=======
    @search_form = SearchForm.new(search_form_params)
    if @search_form.valid?
      current_user.meals.create(cuisine: last_cuisine)
      search = Search.new(search_params)
      @businesses = search.businesses
      @cuisine = Category.where(search_value: search.cuisine).first.display_name
>>>>>>> google_places
    else
      redirect_to root_path
    end
  end

  private

    def search_params
      {
        location: search_form_params[:location],
        meal_history: current_user.meal_history
      }
    end

    def search_form_params
      params.require(:search_form).permit(:location, :cuisine)
    end

    def last_cuisine
      search_form_params[:cuisine]
    end

end
