# Never do this in a real application
# It is just for demonstration
class ValidateContentType
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    if headers["Content-Type"] == "application/json"
      begin
        content = ""
        body.each do |piece|
          content += piece
        end

        JSON.parse(content)

        [status, headers, body]
      rescue JSON::ParserError
        new_body = JSON.generate(error: content)
        response = Rack::Response.new([new_body], status, headers)
        response.finish
      end
    end
  end
end
