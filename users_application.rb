class UsersApplication
  def call(env)
    response = Rack::Response.new
    response.headers["Content-Type"] = "application/json"
    if env["PATH_INFO"] == ""
      response.write(JSON.generate(Database.users))
    elsif env["PATH_INFO"] =~ %r{/\d+}
      id = env["PATH_INFO"].split("/").last.to_i
      user = Database.users[id]
      if user.nil?
        response.status = 404
        response.write("No user with id #{id}")
      else
        response.write(JSON.generate(Database.users[id]))
      end
    else
      response.status = 404
      response.write("Nothing Here!")
    end
    response.finish
  end
end