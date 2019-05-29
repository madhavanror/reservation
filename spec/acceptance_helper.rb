# * Declare environment variables *
ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = %i(json combined_text html)
  config.curl_host = 'http://localhost:3000'
  config.api_name = "API Documentation For Reservation"
  config.request_headers_to_include = ['Accept', 'Content-Type']
end
