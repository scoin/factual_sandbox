class LocationsController < ApplicationController
  def index
    x = API.new
    here = x.factual.geocode(40.709048202397476, -74.01182313493005)
    query = x.factual.table("places") #instantiates query
    query = query.geo("$circle" => {"$center" => [here.first["latitude"], here.first["longitude"]], "$meters" => 1414}) #defines a radius for search
    query = query.select(:name, :address) #selects name and address, also returns distance from geocode
    query = query.page(1, per: 50 ) #number of results for .rows method - putting in 2 as the first argument offsets by the value of per:
                                    #in this case returning results starting at number 51
    query = query.filters("address" => {'$bw'=>"48 Wall"}) #filters by address, $bw is "begins with" see #comparison-operators at http://developer.factual.com/api-docs/
    query = query.sort("name")            # ascending
    query = query.sort_desc("name")       # descending
    query.rows #gets first fifty results because of .page method up there
    query.total_count #total number of results
  end

  def show
  end
end
