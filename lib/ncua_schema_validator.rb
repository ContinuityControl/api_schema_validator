require 'ncua'
require './lib/redis_connector.rb'
class NCUASchemaValidator
  def self.check_schema
    begin
      if ::NCUA.validate_schema!
        RedisConnector.set('ncua_status', 'true')
      end
    rescue StandardError => e
      RedisConnector.set('ncua_status', 'false')

     #Log the error to STDERR
      STDERR.puts "NCUA: #{DateTime.now.iso8601} -- #{e}"
    end
  end
end
