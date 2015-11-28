require 'spec_helper'
require 'rack/test'
require 'json'

describe 'Application' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context '/fdic' do
    context '/status' do
      context 'given a good status' do
        it 'should allow accessing the fdic status' do
          allow(RedisConnector).to receive(:get).with('fdic_status') { "true" }

          get '/fdic/status'
          expect(last_response).to be_ok
          expect(JSON.parse(last_response.body, symbolize_names: true)).to eq( { schema_good: true } )
        end
      end

      context 'given a bad status' do
        it 'should allow accessing the fdic status' do
          allow(RedisConnector).to receive(:get).with('fdic_status') { "false" }

          get '/fdic/status'
          expect(last_response).to be_ok
          expect(JSON.parse(last_response.body, symbolize_names: true)).to eq( { schema_good: false } )
        end
      end
    end
  end
end
