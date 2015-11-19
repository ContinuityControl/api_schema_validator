require 'fdic'
require './lib/redis_connector.rb'
class FDICSchemaValidator
  def self.check_fdic
    begin
    if ::FDIC::BankFind.validate_schema!
      RedisConnector.set('fdic_status', 'true')
    end
    rescue StandardError => e
      RedisConnector.set('fdic_status', 'false')

     #Log the error to STDERR
      STDERR.puts "FDIC: #{DateTime.now.iso8601} -- #{e}"
    end
  end
end
