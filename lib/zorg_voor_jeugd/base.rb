
require 'soap/wsdlDriver'

module ZorgVoorJeugd
  class Base
    WSDL = 'http://zvjtest.interaccess.nl/zvj-ws-v2/services/SignaleringWebService?wsdl'

    def self.create
      driver.wiredump_dev = STDOUT
      driver.endpoint_url = 'http://zvjtest.interaccess.nl/zvj-ws-v2/services/SignaleringWebService/'
      #driver.wiredump_file_base File.join( Rails.root, 'logs', 'soapresults.log')
      param1 = XSD::QName.new(nil, "param1")
      driver.nieuweSignalering({
        "OrganisatieGebruiker" => {
            "OrganisatieNAW" => {
              "OrganisatieNaam" => 'smurfbalet', "OrganisatiePostcode" => '5432FG'
            },
            "GebruikernaamMedewerker" => 'brilsmurf'
          },

          "NieuwSignaal" => {
            "SignaalType" => '1', "Einddatum" => Date.new
          },
          'VerifieerJongere' => "<BurgerServiceNummer>12323</BurgerServiceNummer>"
  #          :BurgerServiceNummer => '12323'
   #       }
      })
    end
    
    def self.update
    end
    
  private
    def self.driver
      @driver ||= SOAP::WSDLDriverFactory.new(WSDL).create_rpc_driver
    end
  end
end