class ApplicationController < ActionController::Base
  helper_method :current_client

  def current_client
    @current_client ||= Client.first
  end
end
