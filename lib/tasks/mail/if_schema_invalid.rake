require './lib/redis_connector.rb'
require './lib/mailer.rb'
namespace :mail do
  desc "test the current cached status, and email if it's bad"
  task :if_schema_invalid, [:to_email_address] do |t, args|
    puts "testing the cached FDIC status"
    if !RedisConnector.get('fdic_status').to_bool
      message =
        <<-mail
The api_schema_validator has tested the fdic gem's schema, and it has been found to be invalid

Please check this manually with the gem, and check the heroku logs as well.
      mail
      Mailer.send(args[:to_email_address],
                  "FDIC API STATUS UNSAFE",
                  message)
    end

    puts "testing the cached FDIC status"
    if !RedisConnector.get('ncua_status').to_bool
      message =
        <<-mail
The api_schema_validator has tested the ncua gem's schema, and it has been found to be invalid

Please check this manually with the gem, and check the heroku logs as well.
      mail
      Mailer.send(args[:to_email_address],
                  "NCUA API STATUS UNSAFE",
                  message)
    end
  end
end
