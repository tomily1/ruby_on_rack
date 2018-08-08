class ApiKey
  def initialize(app)
    @app = app
  end

  def call(env)
    api_key = env["HTTP_API_KEY"]
    user = Database.user_by_api_key(api_key.to_i)

    if user.nil?
      [403, {}, ["Forbidden!"]]
    else
      @app.call(env)
    end
  end
end
