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
      render json: { authentication: {
          challenge: @authentication.encrypted_challenge
        }
      }, status: :created
    end
  end

  # PATCH /authentications/:token
  #
  # This isn't exactly RESTful. This PATCH is really only updating the active
  # attribute to true if the challenge was properly decrypted and matches
  # the authentications challenge. After that, it creates a new session with
  # the token and passes that back for future API call authentications.
  def update
    decrypted_challenge = params[:authentication][:challenge]
    @authentication = Authentication.find_by_challenge(decrypted_challenge)

    if @authentication && @authentication.activate
      session[:token] = @authentication.token
      render json: { status: "Authentication successful" }, status: :ok
    else
      head :forbidden
    end
  end

  # DELETE /authentication/:token
  def destroy

  end
end
