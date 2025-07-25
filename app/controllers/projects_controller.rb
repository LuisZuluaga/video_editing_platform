class ProjectsController < ApplicationController
  def index
    @projects = current_client.projects.includes(:videos).order(created_at: :desc)
  end

  def new
    @project = Project.new
    @video_types = VideoType.all

    if session[:project_data]
      @project.name = session[:project_data]["name"]
      @project.raw_footage_url = session[:project_data]["raw_footage_url"]
      @selected_video_type_ids = session[:project_data]["video_type_ids"] || []
    else
      @selected_video_type_ids = []
    end
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
