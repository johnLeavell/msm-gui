class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create_director
    director = Director.new
    director.name = params.fetch("query_name")
    director.dob = params.fetch("query_dob")
    director.bio = params.fetch("query_bio")
    director.image = params.fetch("query_image")

    if director.valid?
      director.save
      redirect_to("/directors", { :notice => "Director created successfully." })
    else
      redirect_to("/directors", { :notice => "Director failed to create successfully." })
    end
  end

  def update_director
    id = params[:path_id]

    the_director = Director.where( id: id).first

    the_director.name = params[:query_name]
    the_director.dob = params[:query_dob]
    the_director.bio = params[:query_bio]
    the_director.image = params[:query_image]

    the_director.save

    redirect_to("/directors/#{the_director.id}")
  end

  def delete_director
    id = params[:path_id]

    director = Director.where(id: id)

    the_director = director.first
    
    the_director.destroy

    redirect_to("/directors")
  end
  
end
