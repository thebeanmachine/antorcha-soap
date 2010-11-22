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
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sig="http://zvj.interaccess.nl/signalering/" xmlns:com="http://zvj.interaccess.nl/common/">
   <soapenv:Header/>
   <soapenv:Body>
      <sig:nieuweSignalering>
         <sig:OrganisatieGebruiker>
            <com:OrganisatieNAW>
               <com:OrganisatieNaam>Thorax</com:OrganisatieNaam>
               <com:OrganisatiePostcode>3800AD</com:OrganisatiePostcode>
            </com:OrganisatieNAW>
            <com:GebruikernaamMedewerker>snagel</com:GebruikernaamMedewerker>
         </sig:OrganisatieGebruiker>
         <sig:VerifieerJongere>
            <!--You have a CHOICE of the next 2 items at this level-->
            <com:BurgerServiceNummer>123456789</com:BurgerServiceNummer>

            <!--com:Jongere>
               <!--Optional:- ->
               <com:Achternaam>?</com:Achternaam>
               <com:Geboortedatum>?</com:Geboortedatum>
               <com:Geslacht>?</com:Geslacht>
               <com:Postcode>?</com:Postcode>
               <com:Huisnummer>?</com:Huisnummer>
            </com:Jongere-->
         </sig:VerifieerJongere>
         <sig:NieuwSignaal>
            <sig:SignaalType>4</sig:SignaalType>
            <!--Optional:- ->
            <sig:Einddatum>?</sig:Einddatum>-->
         </sig:NieuwSignaal>
      </sig:nieuweSignalering>
   </soapenv:Body>
</soapenv:Envelope>
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
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sig="http://zvj.interaccess.nl/signalering/" xmlns:com="http://zvj.interaccess.nl/common/">
   <soapenv:Header/>
   <soapenv:Body>
      <sig:nieuweSignalering>
         <sig:OrganisatieGebruiker>
            <com:OrganisatieNAW>
               <com:OrganisatieNaam>Thorax</com:OrganisatieNaam>
               <com:OrganisatiePostcode>3800AD</com:OrganisatiePostcode>
            </com:OrganisatieNAW>
            <com:GebruikernaamMedewerker>snagel</com:GebruikernaamMedewerker>
         </sig:OrganisatieGebruiker>
         <sig:VerifieerJongere>
            <!--You have a CHOICE of the next 2 items at this level-->
            <com:BurgerServiceNummer>123456789</com:BurgerServiceNummer>

            <!--com:Jongere>
               <!--Optional:- ->
               <com:Achternaam>?</com:Achternaam>
               <com:Geboortedatum>?</com:Geboortedatum>
               <com:Geslacht>?</com:Geslacht>
               <com:Postcode>?</com:Postcode>
               <com:Huisnummer>?</com:Huisnummer>
            </com:Jongere-->
         </sig:VerifieerJongere>
         <sig:NieuwSignaal>
            <sig:SignaalType>4</sig:SignaalType>
            <!--Optional:- ->
            <sig:Einddatum>?</sig:Einddatum>-->
         </sig:NieuwSignaal>
      </sig:nieuweSignalering>
   </soapenv:Body>
</soapenv:Envelope>
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