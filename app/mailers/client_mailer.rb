class ClientMailer < ApplicationMailer
  def verify_client(email, verification_token)
    @verification_url = "http://#{ENV['HOST_NAME']}/verification?token=#{verification_token}&email=#{email}&client=#{verification_token}"
    mail(to: email, subject: "Verify your recent login attempt")
  end
end
