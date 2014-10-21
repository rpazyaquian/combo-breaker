class HomeController < ApplicationController

  include HomeHelper

  def index
    @cuisine_options = Category.all_categories.sort_by { |category| category[0] }
    @distance_units = [
      :mi,
      :km
    ]
    @search_form = SearchForm.new
  end

  def search
    search = Search.new(search_params, last_cuisine)
    search.search
    @businesses = search.businesses
    @cuisine = search.cuisine
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
