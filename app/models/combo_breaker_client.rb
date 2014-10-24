require 'yelp'

class ComboBreakerClient

  # look at how much nicer this is!

  def initialize
    @client = APIClient.new('yelp')
  end

  def search_api(params)
    location = params[:location]
    category = params[:cuisine]

    results = @client.search(location, category)
  end

  def client
    @client
  end

end