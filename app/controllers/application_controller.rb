class ApplicationController < ActionController::Base
  # Decrypt the request body sent by clients and initialize a box to encrypt
  # the response to the client
  before_action :initialize_encrypted_response
  before_action :decrypt_request_data

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :null_session, if: :json_request?

  def decrypt_request_data
    begin
      # Get the params and convert back to the byte array values
      user_public_key = Base64.decode64(params[:public_key])
      nonce = Base64.decode64(params[:nonce])
      encrypted_data = Base64.decode64(params[:data])

      # Initalize a box and decrypt the params data value
      box = RbNaCl::Box.new(user_public_key, MINO_PRIVATE_KEY)

      decrypted_data = JSON.parse(box.decrypt(nonce, encrypted_data))

      # We still want to use strong parameters in the controller
      # actions to follow, so convert the decrypted data hash back to
      # ActionController Parameters so we can transparently use the data
      # hash like we would if it wasn't encrypted
      @request_params = ActionController::Parameters.new(decrypted_data)
    rescue NoMethodError, RbNaCl::LengthError, RbNaCl::CryptoError
      head 400
    end
  end

  def initialize_encrypted_response
    begin
      @encrypted_response = EncryptedResponse.new(Base64.decode64(params[:public_key]))
    rescue RbNaCl::LengthError
      head 400
    end
  end

  protected

  def json_request?
    request.format.json?
  end
end
