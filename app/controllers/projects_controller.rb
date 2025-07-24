class ProjectsController < ApplicationController
  def index
    @projects = current_client.projects.includes(:videos).order(created_at: :desc)
  end
end
