class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery :with => :exception

  rescue_from(ActiveRecord::RecordNotFound) do
    render_404
  end

  protected

  def render_404
    render status: 404, layout: false
  end

  def render_403
    render status: 403, layout: false
  end
end
