class SandboxMailer < ApplicationMailer
  default from: 'test@example.com' # Set a default sender email

  def test_email(recipient_email)
    @greeting = "Hello from SandboxMailer!"

    mail(
      to: recipient_email,
      subject: 'Test Email for MailCatcher Setup'
    )
  end
end
