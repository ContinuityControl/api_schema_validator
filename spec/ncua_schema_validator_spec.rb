require 'spec_helper'
require File.expand_path '../../lib/ncua_schema_validator.rb', __FILE__

describe NCUASchemaValidator do
  describe '.check_schema' do
    context 'valid schema' do
      it 'sets the fdic status to true' do
        allow(NCUA).to receive(:validate_schema!).and_return(true)

        expect(RedisConnector).to receive(:set).with('ncua_status', 'true')

        NCUASchemaValidator.check_schema
      end
    end

    context 'invalid schema' do
      it 'catches schema exceptions, sets the status to false, and logs to stderr' do
        allow(NCUA).to receive(:validate_schema!).and_raise(StandardError, "THIS ERROR!")
        expect(RedisConnector).to receive(:set).with('ncua_status', 'false')

        expect {
          NCUASchemaValidator.check_schema
        }.to output(/NCUA: .+ -- THIS ERROR!/).to_stderr
      end
    end
  end
end

