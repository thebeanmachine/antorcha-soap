
module ZorgVoorJeugd
  class Base < Struct.new(:organisatie_naw)

    def create signalering
      client = Savon::Client.new 'http://zvjtest.interaccess.nl/zvj-ws-v2/services/SignaleringWebService/'
      result = client.nieuwe_signalering! do |soap|
        soap.namespace = 'http://zvj.interaccess.nl/signalering/'

        xml = Builder::XmlMarkup.new :indent => 2
        
        xml.wsdl :OrganisatieGebruiker, 'xmlns:com' => "http://zvj.interaccess.nl/common/" do
          if organisatie_naw[:uuid]
            xml.com :OrganisatieUUID, organisatie_naw[:uuid]
          else
            xml.com :OrganisatieNAW do
              xml.com :OrganisatieNaam, organisatie_naw[:naam]
              xml.com :OrganisatiePostcode, organisatie_naw[:postcode]
            end
          end
          xml.com :GebruikernaamMedewerker, organisatie_naw[:username]
        end
        xml.wsdl :VerifieerJongere, 'xmlns:com' => "http://zvj.interaccess.nl/common/" do
          if signalering[:bsn]
            xml.com :BurgerServiceNummer, signalering[:bsn]
          else
            # En wat nu als het een tweeling is die elkaar het leven zuur maken? FAIL!
            xml.com :Jongere do
              xml.com :Achternaam, signalering[:achternaam]
              xml.com :Geboortedatum, signalering[:geboortedatum]
              xml.com :Geslacht, signalering[:geslacht]
              xml.com :Postcode, signalering[:postcode]
              xml.com :Huisnummer, signalering[:huisnummer]
            end
          end
        end
        xml.wsdl :NieuwSignaal do
          xml.wsdl :SignaalType, signalering[:signaaltype]
          xml.wsdl :Einddatum, signalering[:einddatum]
        end

        soap.body = xml.target!
      end
      
      unless result.soap_fault? or result.http_error?
        hash = result.to_hash
        Response.new(hash[:nieuwe_signalering_response])
      else
        return Response.new(:status_code => 99, :omschrijving => result.soap_fault.to_s) if result.soap_fault?
        return Response.new(:status_code => 99, :omschrijving => result.http_error.to_s)if result.http_error?
      end
    end
    
    def update
    end
    
  end
  
  class Response < Struct.new(:response)
    
    def status_code
      response[:status_code]
    end
    
    def status_omschrijving
      response[:status_omschrijving]
    end  
    
    def success?
      status_code == '0'
    end
    def warning?
      status_code =~ /^(2|27|39)$/
    end
    def failure?
      not (success? || warning?)
    end
  end
end