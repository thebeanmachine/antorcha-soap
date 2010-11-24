
module ZorgVoorJeugd
  class Base < Struct.new(:organisatie_naw)

    def create jongere, signaaltype
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
          if jongere[:bsn]
            xml.com :BurgerServiceNummer, jongere[:bsn]
          else
            # En wat nu als het een tweeling is die elkaar het leven zuur maken? FAIL!
            xml.com :Jongere do
              xml.com :Achternaam, jongere[:achternaam]
              xml.com :Geboortedatum, jongere[:geboortedatum]
              xml.com :Geslacht, jongere[:geslacht]
              xml.com :Postcode, jongere[:postcode]
              xml.com :Huisnummer, jongere[:huisnummer]
            end
          end
        end
        xml.wsdl :NieuwSignaal do
          xml.wsdl :SignaalType, signaaltype
        end

        soap.body = xml.target!
      end
      
      unless result.soap_fault? or result.http_error?
        hash = result.to_hash
        Response.new(hash[:nieuwe_signalering_response])
      else
        raise result.soap_fault if result.soap_fault?
        raise result.http_error if result.http_error?
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