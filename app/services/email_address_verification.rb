class EmailAddressVerification
  def initialize(user)
    verification = user.verifications.create
    VerificationMailer.verify_email_address(user.email, verification.token).deliver_now
  end
end
