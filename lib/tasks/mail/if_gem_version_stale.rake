require './lib/gem_version_validator.rb'

namespace :mail do
  desc "test the current cached status, and email if it's bad"
  task :if_gem_version_stale, [:to_email_address] do |t, args|
    message = ""
    puts "checking the installed fdic version to see if it's latest"
    unless GemVersionValidator.fdic_latest?
      message += "FDIC out of date, upgrade it\n"
    end
    puts "checking the installed ncua version to see if it's latest"
    unless GemVersionValidator.ncua_latest?
      message += "NCUA out of date, upgrade it\n"
    end
    unless message.empty?
      Mailer.send(args[:to_email_address],
                  "Gems on api_schema_validator are out of date",
                  message)
    end
  end
end
