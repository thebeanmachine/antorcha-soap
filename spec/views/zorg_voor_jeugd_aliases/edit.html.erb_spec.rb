require 'spec_helper'

describe "/zorg_voor_jeugd_aliases/edit.html.erb" do
  include ZorgVoorJeugdAliasesHelper

  before(:each) do
    assigns[:zorg_voor_jeugd_alias] = @zorg_voor_jeugd_alias = stub_model(ZorgVoorJeugdAlias,
      :new_record? => false,
      :organization_id => 1,
      :organization_username => "value for organization_username",
      :gebruikersnaam_medewerker => "value for gebruikersnaam_medewerker",
      :organisatie_naam => "value for organisatie_naam",
      :organisatie_postcode => "value for organisatie_postcode",
      :organisatie_uuid => "value for organisatie_uuid"
    )
  end

  it "renders the edit zorg_voor_jeugd_alias form" do
    render

    response.should have_tag("form[action=#{zorg_voor_jeugd_alias_path(@zorg_voor_jeugd_alias)}][method=post]") do
      with_tag('input#zorg_voor_jeugd_alias_organization_id[name=?]', "zorg_voor_jeugd_alias[organization_id]")
      with_tag('input#zorg_voor_jeugd_alias_organization_username[name=?]', "zorg_voor_jeugd_alias[organization_username]")
      with_tag('input#zorg_voor_jeugd_alias_gebruikersnaam_medewerker[name=?]', "zorg_voor_jeugd_alias[gebruikersnaam_medewerker]")
      with_tag('input#zorg_voor_jeugd_alias_organisatie_naam[name=?]', "zorg_voor_jeugd_alias[organisatie_naam]")
      with_tag('input#zorg_voor_jeugd_alias_organisatie_postcode[name=?]', "zorg_voor_jeugd_alias[organisatie_postcode]")
      with_tag('input#zorg_voor_jeugd_alias_organisatie_uuid[name=?]', "zorg_voor_jeugd_alias[organisatie_uuid]")
    end
  end
end
