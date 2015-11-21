require './lib/redis_connector.rb'
require './lib/mailer.rb'
desc "test the current cached status, and email if it's bad"
task :mail do
  puts "testing the cached FDIC status"
  if !RedisConnector.get('fdic_status').to_bool
    message =
      <<-mail
The api_schema_validator has tested the fdic gem's schema, and it has been found to be invalid

Please check this manually with the gem, and check the heroku logs as well.
    mail
    Mailer.send("engineering+fdic_status_notification@continuity.net",
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
    Mailer.send("engineering+ncua_status_notification@continuity.net",
                "NCUA API STATUS UNSAFE",
                message)
  end
end
