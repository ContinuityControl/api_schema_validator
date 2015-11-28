require 'pony'
class Mailer
  def self.send(address, subject, message)
    Pony.mail(
      to: address,
      from: ENV['FROM_EMAIL_ADDRESS'],
      subject: subject,
      body: message,
      via: :smtp,
      via_options: {
        address: 'smtp.sendgrid.net',
        port: '587',
        domain: ENV['EMAIL_DOMAIN'],
        user_name: ENV['SENDGRID_USERNAME'],
        password: ENV['SENDGRID_PASSWORD'],
        authentication: :plain,
        enable_starttls_auto: true
      }
    )
  end
end
