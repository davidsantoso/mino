class EmailVerification
  def initialize(user)
    verification = user.verifications.create
    VerificationMailer.verify_email_address(user.email, verification.token).deliver_later
  end
end
