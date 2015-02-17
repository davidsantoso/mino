class AuthenticationsController < ApplicationController

  # POST /authentications
  def create
    user = User.find_by_email(params[:user][:email])
    @authentication = user.authentications.create

    if @authentication.errors.any?
      render json: { errors: @authentication.errors }, status: :conflict
    else
      # Manually building json response since we'll be encrypting
      # the message with the users public key before sending back
      render json: {
        authentication: {
          message: @authentication.challenge
        },
        status: :created
      }
    end
  end

  # PUT /authentications/:token
  def update

  end

  # DELETE /authentication/:token
  def destroy

  end
end
