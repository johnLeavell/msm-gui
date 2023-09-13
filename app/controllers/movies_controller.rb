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
    movie = Movie.new
    movie.title = params["query_title"]
    movie.year = params["query_year"]
    movie.duration = params["query_duration"]
    movie.description = params["query_description"]
    movie.image = params["query_image"]
    movie.director_id = params["query_director_id"]

    if movie.valid?
      movie.save
      
      redirect_to("/movies", { :notice => "Movie created successfully." })
    else
      redirect_to("/movies", { :notice => "Movie failed to create successfully. " })
    end
  end

  def update_movie
    id = params["path_id"]

    the_movie = Movie.where( id: id).first

    the_movie.title = params.fetch("query_title")
    the_movie.year = params.fetch("query_year")
    the_movie.duration = params.fetch("query_duration")
    the_movie.description = params.fetch("query_description")
    the_movie.image = params.fetch("query_image")
    the_movie.director_id = params.fetch("query_director_id")

    the_movie.save

    redirect_to("/movies/#{the_movie.id}")
  end

  def delete_movie
    id = params.fetch("path_id")

    movie = Movie.where({:id => id})

    the_movie = movie.first

    the_movie.destroy

    redirect_to('/movies')
  end

end
