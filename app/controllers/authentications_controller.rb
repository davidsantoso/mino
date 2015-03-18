class AuthenticationsController < ApplicationController
  # The user doesn't have their private key yet so this is the only controller
  # action which does not encrypt the response. If we did encrypt it, the user
  # would have no way of decypting since they won't have their private key
  skip_before_filter :initialize_encrypted_response, only: :create

  # POST /authentications
  def create
    user = User.find_by_email(params[:user][:email])
    @authentication = user.authentications.create

    if @authentication.errors.any?
      render json: @encrypted_response.build(@authentication.errors), status: :conflict
    else
      # Manually building json response since we'll be encrypting
      # the message with the users public key before sending back
      render json: { authentication: {
          challenge: @authentication.challenge
        }
      }, status: :created
    end
  end

  # PATCH /authentication/:challenge
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
