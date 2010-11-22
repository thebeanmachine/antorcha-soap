require 'spec_helper'

describe "/zorg_voor_jeugd_aliases/show.html.erb" do
  include ZorgVoorJeugdAliasesHelper
  before(:each) do
    assigns[:zorg_voor_jeugd_alias] = @zorg_voor_jeugd_alias = stub_model(ZorgVoorJeugdAlias,
      :organization_id => 1,
      :organization_username => "value for organization_username",
      :gebruikersnaam_medewerker => "value for gebruikersnaam_medewerker",
      :organisatie_naam => "value for organisatie_naam",
      :organisatie_postcode => "value for organisatie_postcode",
      :organisatie_uuid => "value for organisatie_uuid"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/value\ for\ organization_username/)
    response.should have_text(/value\ for\ gebruikersnaam_medewerker/)
    response.should have_text(/value\ for\ organisatie_naam/)
    response.should have_text(/value\ for\ organisatie_postcode/)
    response.should have_text(/value\ for\ organisatie_uuid/)
  end
end
