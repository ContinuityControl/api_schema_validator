require 'pony'
class Mailer
  def self.send(address, subject, message)
    Pony.mail(
      to: address,
      from: "government_api_validator@continuity.net",
      subject: subject,
      body: message,
      via: :smtp,
      via_options: {
        address: 'smtp.sendgrid.net',
        port: '587',
        domain: 'continuity.net',
        user_name: ENV['SENDGRID_USERNAME'],
        password: ENV['SENDGRID_PASSWORD'],
        authentication: :plain,
        enable_starttls_auto: true
      }
    )
  end
end
