class PaymentsController < ApplicationController
  def new
    session[:project_data] = {
      "title" => params[:project][:title],
      "raw_footage_url" => params[:project][:raw_footage_url],
      "video_type_ids" => params[:project][:video_type_ids]
    }

    @project_data = session[:project_data]
    if @project_data.nil?
      redirect_to new_project_path, alert: "Please create a project first."
      return
    elsif @project_data["video_type_ids"].blank?
      redirect_to new_project_path, alert: "Please select at least one video type."
      return
    end

    @selected_videos = VideoType.find(@project_data["video_type_ids"])
    @total_price = @selected_videos.sum(&:price)
  end
end
