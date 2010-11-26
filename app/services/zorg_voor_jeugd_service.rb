class ZorgVoorJeugdService < ActionAntorcha::Base
  
  REPLIES = {
    :success => "Gesignaleerd",
    :warning => "Gesignaleerd, echter met een waarschuwing",
    :failure => "Signalering mislukt"
  }
  
  def organisatie_naw
    lookup = ZorgVoorJeugdAlias.lookup_alias(organization_id, username)
    lookup.organisatie_as_hash if lookup
  end 
  
  def body
    @params["nieuwe_signalering"].symbolize_keys!
  end
   
  def nieuwe_signalering
    signaleerder = ZorgVoorJeugd::Base.new organisatie_naw    
    response_to signaleerder.create(body)  
  end
  
  def response_to signalering
    
    response_type = if signalering.success?
      :success
    elsif signalering.warning?
      :warning
    else
      :failure
    end        
    
    reply :antwoordbericht_nieuwe_signalering do
      title REPLIES[response_type]
      body :nieuwe_signalering => {
        :status_code => signalering.status_code,
        :omschrijving => signalering.status_omschrijving,
        :signaal_uuid => signalering.signaal_uuid,
        :waarschuwing => signalering.warning?,
        :failure => signalering.failure?
      } 
    end
  end
  
  
  def wijzig_signalering
  end
  
end