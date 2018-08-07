class RidesApplication
  def call(env)
    request = Rack::Request.new(env)
    if env["PATH_INFO"] == ""
      if request.post?
        ride = JSON.parse request.body.read
        Database.add_ride(ride)
        [200, {}, ["Ride received\n"]]
      else
        [200, {}, [Database.rides.to_s]]
      end
    elsif env["PATH_INFO"] =~ %r{/\d+}
      id = env["PATH_INFO"].split("/").last.to_i
      [200, {}, [Database.rides[id].to_s]]
    else
      ["404", {}, ["Nothing Here!"]]
    end
  end
end