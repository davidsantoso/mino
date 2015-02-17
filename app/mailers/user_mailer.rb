class UserMailer < ApplicationMailer
  def verify_email_address(email, verification_token)
    @verification_url = "http://#{ENV['HOST_NAME']}/verification?token=#{verification_token}&email=#{email}"
    mail(to: email, subject: "Verify your mino account")
  end
end
