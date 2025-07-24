class ProjectsController < ApplicationController
  def index
    @projects = current_client.projects.includes(:videos).order(created_at: :desc)
  end

  def new
    @project = Project.new
    @videos = Video.all
  end

  def create
    @project = current_client.projects.build(project_params)
    @project.status = "in_progress"
    @project.pm = ProjectManager.first # default PM

    if @project.save
      video_ids = params[:project][:video_ids].reject(&:blank?)
      @project.videos << Video.find(video_ids)

      # Simulate background notification (sync for now)
      Notification.create!(
        project_manager: @project.pm,
        message: "New project assigned: #{@project.name}",
        delivered_at: Time.current
      )

      redirect_to projects_path, notice: "Project created and in progress!"
    else
      @videos = Video.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :footage_url)
  end
end
