class ApplicationController < ActionController::Base
  helper_method :current_client

  def current_client
    # para efectos del ejercicio, usamos el primer cliente
    @current_client ||= Client.first
  end
end
