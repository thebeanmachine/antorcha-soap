require 'spec_helper'

describe "/zorg_voor_jeugd_aliases/index.html.erb" do
  include ZorgVoorJeugdAliasesHelper

  before(:each) do
    assigns[:zorg_voor_jeugd_aliases] = [
      stub_model(ZorgVoorJeugdAlias,
        :organization_id => 1,
        :organization_username => "value for organization_username",
        :gebruikersnaam_medewerker => "value for gebruikersnaam_medewerker",
        :organisatie_naam => "value for organisatie_naam",
        :organisatie_postcode => "value for organisatie_postcode",
        :organisatie_uuid => "value for organisatie_uuid"
      ),
      stub_model(ZorgVoorJeugdAlias,
        :organization_id => 1,
        :organization_username => "value for organization_username",
        :gebruikersnaam_medewerker => "value for gebruikersnaam_medewerker",
        :organisatie_naam => "value for organisatie_naam",
        :organisatie_postcode => "value for organisatie_postcode",
        :organisatie_uuid => "value for organisatie_uuid"
      )
    ]
  end

  it "renders a list of zorg_voor_jeugd_aliases" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for organization_username".to_s, 2)
    response.should have_tag("tr>td", "value for gebruikersnaam_medewerker".to_s, 2)
    response.should have_tag("tr>td", "value for organisatie_naam".to_s, 2)
    response.should have_tag("tr>td", "value for organisatie_postcode".to_s, 2)
    response.should have_tag("tr>td", "value for organisatie_uuid".to_s, 2)
  end
end
