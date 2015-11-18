require 'sinatra'
require 'sinatra/namespace'

class String
  def to_bool
    return true if self == true || self == "true"
    return false if self == false || self == "false"
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
    if File.read('fdic_schema_valid.dat').to_bool
      send_file 'fdic_safe.svg'
    else
      send_file 'fdic_errors.svg'
    end
  end

  get '/status' do
    content_type :json
    if File.read('fdic_schema_valid.dat').to_bool
      { status: true }.to_json
    else
      { status: false }.to_json
    end
  end
end

namespace '/ncua' do
  get '/badge' do
    if File.read('ncua_schema_valid.dat').to_bool
      send_file 'ncua_safe.svg'
    else
      send_file 'ncua_errors.svg'
    end
  end

  get '/status' do
    content_type :json
    if File.read('ncua_schema_valid.dat').to_bool
      { status: true }.to_json
    else
      { status: false }.to_json
    end
  end
end
