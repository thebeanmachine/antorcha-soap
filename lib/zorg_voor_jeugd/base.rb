
require 'soap/wsdlDriver'

module ZorgVoorJeugd
  class Base
    # WSDL = 'http://zvjtest.interaccess.nl/zvj-ws-v2/services/SignaleringWebService?wsdl'

    def self.create
      client = Savon::Client.new 'http://zvjtest.interaccess.nl/zvj-ws-v2/services/SignaleringWebService/'
      client.nieuweSignalering! do |soap|
        soap.namespace = 'http://zvj.interaccess.nl/signalering/'

        soap.body = <<-XML
          <wsdl:OrganisatieGebruiker xmlns:com="http://zvj.interaccess.nl/common/">
            <com:OrganisatieNAW>
              <com:OrganisatieNaam>Thorax</com:OrganisatieNaam>
              <com:OrganisatiePostcode>3800AD</com:OrganisatiePostcode>
            </com:OrganisatieNAW>
            <com:GebruikernaamMedewerker>snagel</com:GebruikernaamMedewerker>
          </wsdl:OrganisatieGebruiker>
          <wsdl:VerifieerJongere xmlns:com="http://zvj.interaccess.nl/common/">
            <com:BurgerServiceNummer>4234324324324</com:BurgerServiceNummer>
          </wsdl:VerifieerJongere>
          <wsdl:NieuwSignaal>
            <wsdl:SignaalType>4</wsdl:SignaalType>
          </wsdl:NieuwSignaal>
        XML
      end
    end
    
    def self.update
    end
    
  private
    def self.driver
      @driver ||= SOAP::WSDLDriverFactory.new(WSDL).create_rpc_driver
    end
  end
end