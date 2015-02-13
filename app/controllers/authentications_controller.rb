class AuthenticationsController < ApplicationController

  # POST /authentications
  def create
    user = User.find_by_email(params[:user][:email])
    @authentication = user.authentications.create

    if @authentication.errors.any?
      render json: { errors: @authentication.errors }, status: :conflict
    else
      # Manually building json response since we're encrypting
      # the message with the users public key before sending back
      render json: {
        authentication: {
          message: @authentication.message
        },
        status: :created
      }
    end
  end
end
