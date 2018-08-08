class Database
  USER = {
    1 => { name: "Jason", bike: "Cannondale" },
    2 => { name: "Coraline", bike: "Trek" }
  }.freeze

  API_USER = {
    1234 => { name: "admin" }
  }.freeze

  def self.users
    USER
  end

  def self.user_by_api_key(api_key)
    API_USER[api_key]
  end

  RIDES = {
    1 => { user_id: 1, title: "Morning Commute", date: "2016-09-28" },
    2 => { user_id: 1, title: "Evening Commute", date: "2016-09-28" }
  }

  def self.rides
    RIDES
  end

  def self.add_ride(ride)
    RIDES[RIDES.keys.last+1] = ride
  end
end