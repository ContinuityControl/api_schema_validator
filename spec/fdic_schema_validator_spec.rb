require 'spec_helper'
require File.expand_path '../../lib/fdic_schema_validator.rb', __FILE__

describe FDICSchemaValidator do
  describe '.check_schema' do
    context 'valid schema' do
      it 'sets the fdic status to true' do
        allow(FDIC::BankFind).to receive(:validate_schema!).and_return(true)

        expect(RedisConnector).to receive(:set).with('fdic_status', 'true')

        FDICSchemaValidator.check_schema
      end
    end

    context 'invalid schema' do
      it 'catches schema exceptions, sets the status to false, and logs to stderr' do
        allow(FDIC::BankFind).to receive(:validate_schema!).and_raise(StandardError, "THIS ERROR!")
        expect(RedisConnector).to receive(:set).with('fdic_status', 'false')

        expect {
          FDICSchemaValidator.check_schema
        }.to output(/FDIC: .+ -- THIS ERROR!/).to_stderr
      end
    end
  end
end

