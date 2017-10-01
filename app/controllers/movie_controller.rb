class MovieController < ApplicationController
  def index
    #call out to movies API
    #get back some movies
    #save those as... @movies ?

    base_url = "https://api.themoviedb.org/3"
    api_key = "5b19221d20b929615d236692cea743e4"
    base_query = "?api_key=#{api_key}&language=en-US&page=1&adult=false"

    if (params["filter"].nil?)
      response = HTTParty.get "#{base_url}/movie/popular#{base_query}"
    else
      response = HTTParty.get "#{base_url}/search/movie#{base_query}&query=#{params["filter"]}"
    end

    @movies = JSON.parse(response.body)['results']

    respond_to do |format|
      format.html
      format.json { render json: @movies }
    end
  end

  def show
    base_url = "https://api.themoviedb.org/3"
    api_key = "5b19221d20b929615d236692cea743e4"
    base_query = "?api_key=#{api_key}&language=en-US"

    response = HTTParty.get "#{base_url}/movie/#{params["id"]}#{base_query}"

    @movie = JSON.parse(response.body)
  end
end
