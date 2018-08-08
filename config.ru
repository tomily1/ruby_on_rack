require "json"
require_relative "users_application"
require_relative "rides_application"
require_relative "database"
require_relative "api_key"

use ApiKey

map("/users") do
  run UsersApplication.new
end

map("/rides") do
  run RidesApplication.new
end