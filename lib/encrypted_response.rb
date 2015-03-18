class EncryptedResponse

  attr_reader :box
  attr_reader :nonce

  # Initialize the box to encrypt the response to the client in the
  # data key. The user_public_key parameter should have already been
  # Base64 decoded to an array of bytes by the decypt_request_data
  # method in the application controller
  def initialize(user_public_key)
    @box = RbNaCl::Box.new(user_public_key, MINO_PRIVATE_KEY)
    @nonce = RbNaCl::Random.random_bytes(@box.nonce_bytes)
  end

  # This the meat and potatoes of the response. Takes the data to be
  # responded with and encrypts it with the users public key and the
  # Mino app private key. Then once the hash has been built, it Base64
  # encodes each value in the hash so it can be easily transported
  def build(data)
    # Build the main response object and encrypt data parameter passed in
    encrypted_response = Hash.new

    # Set each key value pair in the main response envelope
    encrypted_response["data"] = @box.encrypt(@nonce, data.to_json)
    encrypted_response["public_key"] = ENV["MINO_PUBLIC_KEY"]
    encrypted_response["nonce"] = @nonce

    # Base64 encode all fields so we're not sending byte arrays
    encrypted_response.each do |k, v|
      encrypted_response[k] = Base64.encode64(v)
    end

    # Convert entire response to JSON
    encrypted_response.to_json
  end
end
