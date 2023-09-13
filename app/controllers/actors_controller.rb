class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create_actor
    actor = Actor.new
    actor.name = params["query_name"]
    actor.dob = params["query_dob"]
    actor.bio = params["query_bio"]
    actor.image = params["query_image"]

    if actor.valid?
      actor.save
      
      redirect_to("/actors", { :notice => "Actor created successfully." })
    else
      redirect_to("/actors", { :notice => "Actor failed to crate successfully."})
    end
  end

  def update_actor
    id = params.fetch("path_id")

    the_actor = Actor.where({ :id => id }).at(0)

    the_actor.name = params.fetch("query_name")
    the_actor.dob = params.fetch("query_dob")
    the_actor.bio = params.fetch("query_bio")
    the_actor.image = params.fetch("query_image")

    the_actor.save
    
    redirect_to("/actors/#{the_actor.id}")
  end

  def delete_actor
    id = params.fetch("path_id")

    actor = Actor.where({ :id => id })

    the_actor = actor.first

    the_actor.destroy

    redirect_to("/actors")
  end

end
