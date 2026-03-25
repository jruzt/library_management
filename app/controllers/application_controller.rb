class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Pundit::Authorization
  include JsonRespondable

  rescue_from Pundit::NotAuthorizedError, with: :render_not_authorized

  protected

  def render_not_authorized
    render json: json_error_response(
      status: :forbidden,
      title: "Forbidden",
      detail: "You are not authorized to perform this action."
    ), status: :forbidden
  end
end
