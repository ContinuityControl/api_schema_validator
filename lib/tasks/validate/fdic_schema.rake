require './lib/fdic_schema_validator.rb'
namespace :validate do
  desc "test the FDIC's api"
  task :fdic_schema do
    puts "testing the FDIC schema"
    FDICSchemaValidator.check_schema
  end
end
