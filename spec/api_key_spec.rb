require "rubygems"
require "rack/test"
require_relative "../database"
require_relative "../api_key"

describe ApiKey do
  include Rack::Test::Methods

  let(:app) do
    ApiKey.new(-> env{ Rack::Response.new("ok").finish })
  end

  context "test_reject_authenticated" do
    it "returns 403 error" do
      get '/'
      expect(last_response.status).to eq 403
      expect(last_response.body).to eq "Forbidden!"
    end
  end

  context "test_authenticated" do
    it "returns 200 OK response" do
      get '/', {}, 'HTTP_API_KEY' => '1234'
      expect(last_response.status).to eq 200
      expect(last_response.body).to eq "ok"
    end
  end
end
