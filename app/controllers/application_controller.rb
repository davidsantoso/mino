class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session, if: :json_request?

  # GET /verification
  # Email address verification endpoint. No real RESTful action for it
  # so it's going here for now.
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

  def decrypt_request_data
    user_public_key = Base64.decode64(params[:public_key])
    nonce = Base64.decode64(params[:nonce])
    encrypted_data = Base64.decode64(params[:data])

    box = RbNaCl::Box.new(user_public_key, MINO_PRIVATE_KEY)
    decrypted_data = JSON.parse(box.decrypt(nonce, encrypted_data))

    @data = ActionController::Parameters.new(decrypted_data)
  end

  protected

  def json_request?
    request.format.json?
  end
end
