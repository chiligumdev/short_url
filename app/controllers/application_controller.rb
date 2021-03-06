require 'application_responder'

# app/controllers/application_controller
class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def after_sign_in_path_for(_resource_or_scope)
    links_path
  end
end
