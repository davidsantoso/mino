class ApplicationController < ActionController::Base
  # Decrypt the request body sent by clients and initialize a box to encrypt
  # the response to the client
  before_filter :decrypt_request_data, except: [:verification]
  before_filter :initialize_encrypted_response, except: [:verification]

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session, if: :json_request?

  # GET /verification
  # Email address verification endpoint. No real RESTful action for it...
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
    # Get the params and convert back to the byte array values
    @user_public_key = Base64.decode64(params[:public_key])
    nonce = Base64.decode64(params[:nonce])
    encrypted_data = Base64.decode64(params[:data])

    # Initalize a box and decrypt the params data value
    box = RbNaCl::Box.new(@user_public_key, MINO_PRIVATE_KEY)
    decrypted_data = JSON.parse(box.decrypt(nonce, encrypted_data))

    # We still want to use strong parameters in the controller
    # actions to follow, so convert the decrypted data hash back to
    # ActionController Parameters so we can transparently use the data
    # hash like we would if it wasn't encrypted
    @data = ActionController::Parameters.new(decrypted_data)
  end

  def initialize_encrypted_response
    @encrypted_response = EncryptedResponse.new(@user_public_key)
  end

  protected

  def json_request?
    request.format.json?
  end
end
