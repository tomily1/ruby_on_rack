class Database
  USER = {
      1 => { name: "Jason", bike: "Cannondale" },
      2 => { name: "Coraline", bike: "Trek" }
  }

  def self.users
    USER
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