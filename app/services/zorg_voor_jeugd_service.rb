class ZorgVoorJeugdService < ActionAntorcha::Base
  
  REPLIES = {
  :success => {
    :title => "Gesignaleerd",
    :waarschuwing => false,
    :failure => false
    },
  :warning => {
    :title => "Gesignaleerd, echter met een waarschuwing",
    :waarschuwing => true,
    :failure => false
    },
  :failure => {
    :title => "Signalering mislukt",
    :waarschuwing => false,
    :failure => true
    }
  }
  
  def organisatie_naw
    lookup = ZorgVoorJeugdAlias.lookup_alias(organization_id, username)
    lookup.organisatie_as_hash if lookup
  end 
  
  def body
    @params["nieuwe_signalering"].symbolize_keys!
  end
   
  def nieuwe_signalering
    signalering = ZorgVoorJeugd::Base.new organisatie_naw    
    response_to signalering.create body    
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
      title REPLIES[response_type][:title]
      body :nieuwe_signalering => {
        :status_code => signalering.status_code,
        :omschrijving => signalering.status_omschrijving,
        :waarschuwing => REPLIES[response_type][:waarschuwing],
        :failure => REPLIES[response_type][:failure]
        } 
    end
  end
  
  
  def wijzig_signalering
  end
  
end