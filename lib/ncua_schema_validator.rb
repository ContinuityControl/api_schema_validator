require 'ncua'
class NCUASchemaValidator
  def self.check_fdic
    begin
    if ::NCUA.validate_schema!
      File.open("ncua_schema_valid.dat", "w") do |file|
        file << true
      end
    end
    rescue StandardError => e
      File.open("ncua_schema_valid.dat", "w") do |file|
        file << false
      end

      File.open("errors.log", "a") do |file|
        file.puts "NCUA: #{DateTime.now.iso8601} -- #{e}"
      end
    end
  end
end
