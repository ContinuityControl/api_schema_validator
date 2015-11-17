require './lib/fdic_schema_validator.rb'
desc "test the FDIC's api"
task :test_fdic do
  puts "testing the FDIC schema"
  FDICSchemaValidator.check_fdic
end
