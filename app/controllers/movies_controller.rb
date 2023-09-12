class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create_movie
    @movie = Movie.new
    @movie.title = params["query_title"]
    @movie.year = params["query_year"]
    @movie.duration = params["query_duration"]
    @movie.description = params["query_description"]
    @movie.image = params["query_image"]
    @movie.director_id = params["query_director_id"]

    if @movie.valid?
      @movie.save
      
      redirect_to("/movies", { :notice => "Movie created successfully." })
    else
      redirect_to("/movies", { :notice => "Movie failed to create successfully. " })
    end
  end

end
