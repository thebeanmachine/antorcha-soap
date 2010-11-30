class ZorgVoorJeugdService < ActionAntorcha::Base
  
  NIEUWE_SIGNALERING_REPLIES = {
    :success => "Gesignaleerd",
    :warning => "Gesignaleerd, echter met een waarschuwing",
    :failure => "Signalering mislukt"
  }
  
  WIJZIG_SIGNALERING_REPLIES = {
    :success => "Signalering gewijzigd",
    :warning => "Signalering gewijzigd, echter met een waarschuwing",
    :failure => "Wijzigen signalering mislukt"
  }
  
   
  def nieuwe_signalering
    if organisatie_naw

      zorg_voor_jeugd = ZorgVoorJeugd::Base.new organisatie_naw    
      response_to zorg_voor_jeugd.create(body), :antwoordbericht_nieuwe_signalering, NIEUWE_SIGNALERING_REPLIES
    else
      reply :antwoordbericht_nieuwe_signalering do
        title "Gebruiker en organisatie niet aangemeld bij koppeling"
        body :antwoordbericht_nieuwe_signalering => {
          :status_code => '99',
          :omschrijving => "Gebruiker en organisatie niet aangemeld bij koppeling"
        }
      end
    end
  end

  def wijzig_signalering
    if organisatie_naw
      signaleerder = ZorgVoorJeugd::Base.new organisatie_naw    
      response_to signaleerder.update(body('wijzig_signalering')), :antwoordbericht_wijziging_signalering, WIJZIG_SIGNALERING_REPLIES
    else
      reply :antwoordbericht_wijziging_signalering do
        title "Gebruiker en organisatie niet aangemeld bij koppeling"
        body :antwoordbericht_wijziging_signalering => {
          :status_code => '99',
          :omschrijving => "Gebruiker en organisatie niet aangemeld bij koppeling"
        }
      end
    end
  end

  def response_to signalering, step_symbol, replies
    response_type = if signalering.success?
      :success
    elsif signalering.warning?
      :warning
    else
      :failure
    end        
    
    reply step_symbol do
      title replies[response_type]
      body step_symbol => {
        :status_code => signalering.status_code,
        :omschrijving => signalering.status_omschrijving,
        :signaal_uuid => signalering.signaal_uuid,
        :waarschuwing => signalering.warning?,
        :failure => signalering.failure?
      } 
    end
  end
  
  def organisatie_naw
    @organisatie_naw ||= find_organisatie_naw
  end 
  
  def find_organisatie_naw
    lookup = ZorgVoorJeugdAlias.lookup_alias(organization_id, username)
    lookup.organisatie_as_hash if lookup
  end
  
  def body root = "nieuwe_signalering"
    if @params[root].kind_of?(Hash)
      @params[root].symbolize_keys!
    else
      {}
    end
  end
  
  
  
  
end