class ClientVerification
  def initialize(client)
    verification = client.verifications.create
    VerificationMailer.verify_client(client.user.email, client.signature, verification.token).deliver_now
  end
end
