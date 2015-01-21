class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session, if: :json_request?
  respond_to :json

  protected

  def json_request?
    request.format.json?
  end
end
