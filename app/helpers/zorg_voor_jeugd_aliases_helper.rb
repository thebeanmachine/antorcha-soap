module ZorgVoorJeugdAliasesHelper

  def antorcha_aanduiding zvj_alias
    [ zvj_alias.organization.title, zvj_alias.organization_username ].join(" / ")
  end
  
  def zorg_voor_jeugd_aanduiding zvj_alias
    [ zvj_alias.organisatie_naam_and_postcode? ? 
      [zvj_alias.organisatie_naam, zvj_alias.organisatie_postcode].join(' , ') : zvj_alias.organisatie_uuid,
      zvj_alias.gebruikersnaam_medewerker
    ].join " / "
  end
end
