class SoapApplication
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    response.headers["Content-Type"] = "application/xml"
    response.write(product_xml)
    response.finish
  end

  def product_xml
    xml = Builder::XmlMarkup.new( :indent => 2 )
    xml.instruct! :xml, :encoding => "ASCII"
    xml.rides do |p|
      Database.rides.each do |ride|
        p.ride ride[1][:title]
      end
    end
  end
end
