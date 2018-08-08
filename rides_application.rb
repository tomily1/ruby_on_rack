class RidesApplication
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    response.headers["Content-Type"] = "application/json"

    case request.path_info
    when request.post? && ""
      post_a_ride(request, response)
    when request.get? && ""
      get_all_rides(request, response)
    when %r{/\d+}
      get_a_ride(request, response)
    else
      missing(request, response)
    end
    response.finish
  end

  def post_a_ride(request, response)
    ride = JSON.parse(request.body.read)
    if ride["user_id"].nil?
      error(response, "user_id field is required")
    else
      Database.add_ride(ride)
      response.write(JSON.generate({message: "Ride received"}))
    end
  rescue JSON::ParserError
    error(response, "Invalid JSON")
  end

  def get_all_rides(_request, response)
    response.write(JSON.generate(Database.rides))
  end

  def get_a_ride(request, response)
    id = request.path_info.split("/").last.to_i
    response.write(JSON.generate(Database.rides[id]))
  end

  def missing(_request, response)
    error(response, "Nothing here!", 404)
  end

  def error(response, message, status = 400)
    response.status = status
    response.write("ERROR: #{message}")
  end
end