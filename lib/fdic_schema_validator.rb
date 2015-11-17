require 'fdic'
class FDICSchemaValidator
  def self.check_fdic
    begin
    if ::FDIC::BankFind.validate_schema!
      File.open("fdic_schema_valid.dat", "w") do |file|
        file << true
      end
    end
    rescue StandardError => e
      File.open("fdic_schema_valid.dat", "w") do |file|
        file << false
      end

      File.open("errors.log", "a") do |file|
        file.puts "FDIC: #{DateTime.now.iso8601} -- #{e}"
      end
    end
  end
end
