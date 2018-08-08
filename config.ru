require "json"
require_relative "users_application"
require_relative "rides_application"
require_relative "database"
require_relative "api_key"
require_relative "validate_content_type"

use Rack::Runtime
use Rack::ContentType, "application/json"
use Rack::ContentLength

use Rack::ETag
use Rack::Deflater

if ENV["RACK_ENV"] == "development"
  use Rack::Reloader
end
use ApiKey
use ValidateContentType

map("/users") do
  run UsersApplication.new
end

map("/rides") do
  run RidesApplication.new
end
