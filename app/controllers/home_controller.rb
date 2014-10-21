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
    else
      redirect_to root_path
    end
  end

  private

    def search_params
      {
        location: search_form_params[:location],
        radius: meters(search_form_params[:radius_distance], search_form_params[:radius_units])
      }
    end

    def search_form_params
      params.require(:search_form).permit(:location, :cuisine, :radius_distance, :radius_units)
    end

    def last_cuisine
      Category.where(search_value: search_form_params[:cuisine]).first
    end

    def meters(distance, units)
      Unit("#{distance} #{units}").convert_to('m').scalar
    end

end
