class API
  attr_accessor :factual
  def initialize
    @factual = Factual.new(ENV["API_KEY"], ENV["API_SECRET"])
  end

end
