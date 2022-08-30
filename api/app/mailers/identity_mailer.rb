class IdentityMailer < ApplicationMailer
  def send_token(email, token)
    @token = token
    @email = email

    mail(to: @email, subject: "Token generated")
  end
end
