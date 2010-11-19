class Operation < ActiveRecord::Base
  include CatchUniqueConstraintViolation

  validates_uniqueness_of :message_id
  
  belongs_to :message
  
  #after_create :post_xml  
  #after_update :put_xml
   
  
  def post_xml
    # This is a test ZVJ SOAP envelope! It's static but we will make it dynamic really really soon! Oh yeah btw: ...SOAP SUCKS :D
    soap_data = <<-EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <SOAP-ENV:Envelope
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
        SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
        
        <SOAP-ENV:Body>
        
          <zvj:SignaleringRequest xmlns:zvj="http://model.zvj.nl/signalering/">
            <Organisatie>Thorax</Organisatie>
            <BurgerServiceNummer>12345678</BurgerServiceNummer>
            <GeboorteDatum>11/11/2001</GeboorteDatum>
            <Jongere>HENKIE</Jongere>
            <SignaalType>2</SignaalType>
            <mutatienummer>123123123</mutatienummer>
          </zvj:SignaleringRequest>
  
        </SOAP-ENV:Body>
      </SOAP-ENV:Envelope>
    EOF
    
    # Set Headers
    headers = {
      'Content-type'=> 'text/xml; charset=utf-8',
      #'SOAPAction'=> '""',
      #'User-Agent'=> '""',
      'Host'=>  'zvjtest.interaccess.nl',
      'Content-Length'=> soap_data.length
    }
    
    #create session object
    uri = URI.parse("http://zvjtest.interaccess.nl:444")
    path = "/zvj-ws-v2/services/SignaleringWebService/"
    http_session = Net::HTTP.new(uri.host, uri.port)
    http_session.use_ssl = true
    
    #start the http session
    http_session.start do |http|
      # create the request
      req = Net::HTTP::Post.new(path)
      req.basic_auth "snagel", "maandag1"
      
      headers.each{|key, val| req.add_field(key, val)}
      
      # Post the request
      resp, data = http.request(req, soap_data)
      p 'Code = ' + resp.code
      p 'Message = ' + resp.message
      resp.each { |key, val| puts key + ' = ' + val }
      p data
    end
  end
  
    # Yes I know..... It will be dry-up'ed soon!
    def put_xml
    soap_data = <<-EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <SOAP-ENV:Envelope
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"
        SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
        
        <SOAP-ENV:Body>
        
          <zvj:SignaleringRequest xmlns:zvj="http://model.zvj.nl/signalering/">
            <Organisatie>Thorax</Organisatie>
            <BurgerServiceNummer>12345678</BurgerServiceNummer>
            <GeboorteDatum>11/11/2001</GeboorteDatum>
            <Jongere>HENKIE</Jongere>
            <SignaalType>2</SignaalType>
            <mutatienummer>123123123</mutatienummer>
          </zvj:SignaleringRequest>
  
        </SOAP-ENV:Body>
      </SOAP-ENV:Envelope>
    EOF
    
    # Set Headers
    headers = {
      'Content-type'=> 'text/xml; charset=utf-8',
      #'SOAPAction'=> '""',
      #'User-Agent'=> '""',
      'Host'=>  'zvjtest.interaccess.nl',
      'Content-Length'=> soap_data.length
    }
    
    #create session object
    uri = URI.parse("http://zvjtest.interaccess.nl:444")
    path = "/zvj-ws-v2/services/SignaleringWebService/"
    http_session = Net::HTTP.new(uri.host, uri.port)
    http_session.use_ssl = true
    
    #start the http session
    http_session.start do |http|
      # create the request
      req = Net::HTTP::Put.new(path)
      req.basic_auth "snagel", "maandag1"
      
      headers.each{|key, val| req.add_field(key, val)}
      
      # Post the request
      resp, data = http.request(req, soap_data)
      p 'Code = ' + resp.code
      p 'Message = ' + resp.message
      resp.each { |key, val| puts key + ' = ' + val }
      p data
    end
  end
end