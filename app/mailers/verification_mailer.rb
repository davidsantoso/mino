class VerificationMailer < ApplicationMailer
  def verify_email_address(email, verification_token)
    @verification_url = "http://#{ENV['HOST_NAME']}/verification?token=#{verification_token}&email=#{email}"
    mail(to: email, subject: "Verify your mino account")
  end

  def verify_client(email, client_signature, verification_token)
    @verification_url = "http://#{ENV['HOST_NAME']}/verification?token=#{verification_token}&signature=#{client_signature}"
    mail(to: email, subject: "Verify your mino login attempt")
  end
end
