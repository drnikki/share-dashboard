class ProjectController < ApplicationController
  # adds and shows, and later will delete projects
  def add

  end

  def create
    # creates a new project
    @project = Project.new(params[:project]);

    @project.save
    redirect_to :action => :add
  end

  def show
    #p params[:id]
    @project = Project.find(params[:id])
  end

  def list
    # @todo, also meh.
    # @project = Project.find
  end

end
