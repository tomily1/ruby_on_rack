require "rubygems"
require "rack/test"
require "json"
require_relative "../database"
require_relative "../rides_application"

describe RidesApplication do
  include Rack::Test::Methods

  let(:app) do
    RidesApplication.new
  end

  context "gets rides" do
    it "returns 200 with json response" do
      get '/'
      expect(last_response.status).to eq 200
      expect(last_response.body).to eq JSON.generate(Database.rides)
    end

    it "returns user based on id parameter" do
      id = 1
      get "/#{id}"
      expect(last_response.status).to eq 200
      expect(last_response.body).to eq JSON.generate(Database.rides[id])
    end

    it "returns 404 if user id not found" do
      id = 12
      get "/#{id}"
      expect(last_response.status).to eq 404
      expect(last_response.body).to eq "ERROR: Nothing here!"
    end
  end
end
