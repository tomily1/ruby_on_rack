require "rubygems"
require "rack/test"
require "json"
require "builder"
require_relative "../soap_application"

describe SoapApplication do
  include Rack::Test::Methods

  let(:app) do
    SoapApplication.new
  end

  context "XML format" do
    it "returns all ride" do
      get "/"
      expect(last_response.status).to eq 200
      expect(last_response.body).to eq "<?xml version=\"1.0\" encoding=\"ASCII\"?>\n<rides>\n  <ride>Morning Commute</ride>\n  <ride>Evening Commute</ride>\n</rides>\n"
    end
  end
end
