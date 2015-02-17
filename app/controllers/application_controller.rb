class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session, if: :json_request?

  # GET /verification
  def verification
    if params[:email] && params[:token]
      user = User.find_by_email(params[:email])

      if user.email_address_verified?(params[:token])
        render "users/verification"
        return true
      end
    end

    head :forbidden
  end

  protected

  def json_request?
    request.format.json?
  end
end
