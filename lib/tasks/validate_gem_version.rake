require './lib/gem_version_validator.rb'

desc "test the current cached status, and email if it's bad"
task :check_gem_versions do
  message = ""
  puts "checking the installed fdic version to see if it's latest"
  if GemVersionValidator.fdic_latest?
    message += "FDIC out of date, upgrade it\n"
  end
  puts "checking the installed ncua version to see if it's latest"
  if GemVersionValidator.ncua_latest?
    message += "NCUA out of date, upgrade it\n"
  end
  if !message.empty?
    Mailer.send("engineering+fdic_status_notification@continuity.net",
                "Gems on api_schema_validator are out of date",
                message)
  end
end
