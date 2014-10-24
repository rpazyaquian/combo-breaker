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
    @search_form = SearchForm.new(search_form_params)
    if @search_form.valid?
      current_user.meals.create(cuisine: last_cuisine)
      begin
        search = Search.new(search_params)
      rescue StandardError => e
        flash[:error] = e.message
        redirect_to root_path
      end
      if search
        @init_coords = Geocoder.search(search_form_params[:location]).first.data["geometry"]["location"]
        @businesses = search.businesses
        @cuisine = Category.where(search_value: search.cuisine).first.display_name
      end
    else
      flash[:error] = "No location specified."
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
