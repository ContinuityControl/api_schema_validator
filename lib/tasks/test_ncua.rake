require './lib/ncua_schema_validator.rb'
desc "test the NCUA's api"
task :test_ncua do
  puts "testing the NCUA schema"
  NCUASchemaValidator.check_fdic
end
