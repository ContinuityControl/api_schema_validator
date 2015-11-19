require 'sinatra'
require 'sinatra/namespace'
require './lib/redis_connector.rb'

class String
  def to_bool
    return true if self == "true"
    return false if self == "false"
  end
end

configure do
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
  Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib|
    require File.basename(lib, '.*')
  }
end

namespace '/fdic' do
  get '/badge' do
    if fdic_valid?
      send_file 'fdic_safe.svg'
    else
      send_file 'fdic_errors.svg'
    end
  end

  get '/status' do
    content_type :json
    { schema_good: fdic_valid? }.to_json
  end
end

namespace '/ncua' do
  get '/badge' do
    if ncua_valid?
      send_file 'ncua_safe.svg'
    else
      send_file 'ncua_errors.svg'
    end
  end

  get '/status' do
    content_type :json
    { schema_good: ncua_valid? }.to_json
  end
end

def fdic_valid?
  RedisConnector.get('fdic_status').to_bool
end

def ncua_valid?
  RedisConnector.get('ncua_status').to_bool
end
