require './lib/ncua_schema_validator.rb'
namespace :validate do
  desc "test the NCUA's api"
  task :ncua_schema do
    puts "testing the NCUA schema"
    NCUASchemaValidator.check_fdic
  end
end
