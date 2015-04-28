class ClientVerification
  def initialize(client)
    verification = client.verifications.create
    VerificationMailer.verify_client(client.user.email, client.token, verification.token).deliver_now
  end
end
