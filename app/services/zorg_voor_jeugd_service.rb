class ZorgVoorJeugdService < ActionAntorcha::Base
  
  def organisatie_naw
    {:naam => 'Thorax', :postcode => '3800AD', :username => 'thebeanmachine'}
  end 
  
  def body
    @params["nieuwe_signalering"].symbolize_keys!
  end
   
  def nieuwe_signalering
    signalering = ZorgVoorJeugd::Base.new organisatie_naw
    response = signalering.create body
    if response.success?
      reply :antwoordbericht_nieuwe_signalering do
        title "Gesignaleerd"
        body :nieuwe_signalering => {
          :status_code => response.status_code,
          :omschrijving => response.status_omschrijving
        }
      end
    elsif response.warning?
      reply :antwoordbericht_nieuwe_signalering do
        title "Gesignaleerd, echter met een waarschuwing"
        body :nieuwe_signalering => {
          :status_code => response.status_code,
          :omschrijving => response.status_omschrijving,
          :waarschuwing => true
        }
      end
    else
      reply :antwoordbericht_nieuwe_signalering do
        title "Signalering mislukt"
        body :nieuwe_signalering => {
          :status_code => response.status_code,
          :omschrijving => response.status_omschrijving,
          :failure => true
        }
      end
    end
  end
  
  def wijzig_signalering
  end
  
end