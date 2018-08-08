class UsersApplication
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    response.headers["Content-Type"] = "application/json"

    case request.path_info
    when "" || "/"
      get_all_users(request, response)
    when request.get? && %r{/\d+}
      get_a_user(request, response)
    else
      missing(request, response)
    end
    response.finish
  end

  def get_all_users(_request, response)
    response.write(JSON.generate(Database.users))
  end

  def get_a_user(request, response)
    id = request.path_info.split("/").last.to_i
    user = Database.users[id]
    if user.nil?
      error(response, "No user with id #{id}", 404)
    else
      response.write(JSON.generate(Database.users[id]))
    end
  end

  def missing(_request, response)
    error(response, "Nothing here!", 404)
  end

  def error(response, message, status = 400)
    response.status = status
    response.write("ERROR: #{message}")
  end
end
