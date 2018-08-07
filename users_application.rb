class UsersApplication
  def call(env)
    response = Rack::Response.new
    response.headers["Content-Type"] = "application/json"
    if env["PATH_INFO"] == ""
      response.write(JSON.generate(Database.users))
    elsif env["PATH_INFO"] =~ %r{/\d+}
      id = env["PATH_INFO"].split("/").last.to_i
      response.write(JSON.generate(Database.users[id]))
    else
      response.status = 404
      response.write("Nothing Here!")
    end
    response.finish
  end
end