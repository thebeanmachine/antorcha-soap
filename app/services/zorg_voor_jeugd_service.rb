class ZorgVoorJeugdService < ActionAntorcha::Base
  
  def organisatie_naw
    {:naam => 'Thorax', :postcode => '3800AD', :username => 'thebeanmachine'}
  end 
  
  def nieuwe_signalering
    signalering = ZorgVoorJeugd::Base.new organisatie_naw
    response = signalering.create body #[:jongere], body[:signaaltype]
    
    if response.success?
      reply :antwoordbericht_nieuwe_signalering do |msg|
        msg.title = "Gesignaleerd"
        msg.body = { :nieuwe_signalering => {
          :status_code => response.status_code,
          :omschrijving => response.omschrijving
        } }
      end
    elsif response.warning?
      reply :antwoordbericht_nieuwe_signalering do |msg|
        msg.title = "Gesignaleerd, echter met een waarschuwing"
        msg.body = { :nieuwe_signalering => {
          :status_code => response.status_code,
          :omschrijving => response.omschrijving,
          :waarschuwing => true
        } }
      end
    else
      reply :antwoordbericht_nieuwe_signalering do |msg|
        msg.title = "Signalering mislukt"
        msg.body = { :nieuwe_signalering => {
          :status_code => response.status_code,
          :omschrijving => response.omschrijving,
          :failure => true
        } }
      end
    end
  end
  
  def wijzig_signalering
  end
  
end