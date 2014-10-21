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
    search = Search.new
    search.search(search_params, last_cuisine)
    @businesses = search.businesses
    @cuisine = search.cuisine
    @location = search.location
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
      search_form_params[:cuisine].to_sym
    end

    def meters(distance, units)
      Unit("#{distance} #{units}").convert_to('m').scalar
    end

end
