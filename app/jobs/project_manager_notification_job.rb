class ProjectManagerNotificationJob < ApplicationJob
  queue_as :default

  def perform(project_id)
    project = Project.find(project_id)
    project_manager = project.project_manager

    Notification.create!(
      project_manager_id: project_manager.id,
      project: project,
      message: "A new project '#{project.title}' has been assigned to you.",
      delivered_at: Time.current
    )
  end
end
