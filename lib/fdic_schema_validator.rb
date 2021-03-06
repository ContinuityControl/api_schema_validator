require 'fdic'
require './lib/redis_connector.rb'
class FDICSchemaValidator
  def self.check_schema
    begin
    if ::FDIC::BankFind.validate_schema!
      RedisConnector.set('fdic_status', 'true')
    end
    rescue StandardError => e
      RedisConnector.set('fdic_status', 'false')

     #Log the error to STDERR
      $stderr.puts "FDIC: #{DateTime.now.iso8601} -- #{e}"
    end
  end
end
