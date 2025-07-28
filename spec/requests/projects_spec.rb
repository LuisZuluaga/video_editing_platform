require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let(:client) { Client.create!(name: "Test Client", email: "client@example.com") }
  let(:project_manager) { ProjectManager.create!(name: "Test Manager", email: "om@test.com") }
  let(:video_type) { VideoType.create!(name: "Test Video", format: "mp4", price: 100.0) }
  let!(:project) { Project.create!(title: "Demo Project", client: client, project_manager: project_manager, raw_footage_url: "http://example.com/video.mp4", status: "in_progress") }

  describe "GET /projects" do
    it "returns a list of projects" do
      get projects_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Demo Project")
    end
  end

  describe "GET /projects/:id" do
    it "shows the project details" do
      get project_path(project)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Demo Project")
    end
  end

  describe "GET /projects/new" do
    it "renders the new project form" do
      get new_project_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("New Video Project")
    end
  end

  describe "POST /projects" do
    it "creates a new project" do
      expect {
        post projects_path, params: {
          project: {
            title: "New Test Project",
            client_id: client.id,
            raw_footage_url: "http://example.com/new.mp4",
            video_type_ids: [video_type.id]
          }
        }
      }.to have_enqueued_job(ProjectManagerNotificationJob)

      expect(Project.count).to eq(2)
      expect(response).to redirect_to(projects_path)
      expect(flash[:notice]).to eq("Project created and in progress!")
    end
  end
end
