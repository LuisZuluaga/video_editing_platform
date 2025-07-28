class ProjectsController < ApplicationController
  def index
    @projects = current_client.projects.includes(:videos).order(created_at: :desc)
  end

  def new
    @project = Project.new
    @video_types = VideoType.all
    
    if session[:project_data]
      @project.title = session[:project_data]["title"]
      @project.raw_footage_url = session[:project_data]["raw_footage_url"]
      @selected_video_type_ids = session[:project_data]["video_type_ids"] || []
    else
      @selected_video_type_ids = []
    end
  end

  def create
    if session[:project_data]
      project_params = session[:project_data].with_indifferent_access
      session.delete(:project_data)
    end

    @project = current_client.projects.build(project_params.except("video_type_ids"))
    @project.status = "in_progress"
    @project.project_manager = ProjectManager.first # default PM

    if @project.save

      video_ids = project_params[:video_type_ids].reject(&:blank?)
      video_ids.each do |video_type_id|
        video_type = VideoType.find(video_type_id)
        @project.videos.create!(
          title: video_type.name,
          price: video_type.price,
          format: video_type.format,
          video_type: video_type,
          notes: "Video created from type #{video_type.name}"
        )
      end

      ProjectManagerNotificationJob.perform_later(@project.id)

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
