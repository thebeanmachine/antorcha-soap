require 'spec_helper'

describe ZorgVoorJeugdAlias do
  before(:each) do
    @valid_attributes = {
      :organization_id => 1,
      :organization_username => "value for organization_username",
      :gebruikersnaam_medewerker => "value for gebruikersnaam_medewerker",
      :organisatie_naam => "value for organisatie_naam",
      :organisatie_postcode => "value for organisatie_postcode",
      :organisatie_uuid => "value for organisatie_uuid"
    }
  end

  it "should create a new instance given valid attributes" do
    ZorgVoorJeugdAlias.create!(@valid_attributes)
  end
  
  it "should be able to lookup an alias" do
    @alias = ZorgVoorJeugdAlias.create! \
      :organization_id => 123,
      :organization_username => "jan_melder",
      :gebruikersnaam_medewerker => "value for gebruikersnaam_medewerker",
      :organisatie_naam => "value for organisatie_naam",
      :organisatie_postcode => "value for organisatie_postcode",
      :organisatie_uuid => "value for organisatie_uuid"

    result = ZorgVoorJeugdAlias.lookup_alias 123, 'jan_melder'
    result.should == @alias
  end

  it "should be able to lookup an alias and not find anything" do
    @alias = ZorgVoorJeugdAlias.create! \
      :organization_id => 123,
      :organization_username => "jan_melder",
      :gebruikersnaam_medewerker => "value for gebruikersnaam_medewerker",
      :organisatie_naam => "value for organisatie_naam",
      :organisatie_postcode => "value for organisatie_postcode",
      :organisatie_uuid => "value for organisatie_uuid"

    result = ZorgVoorJeugdAlias.lookup_alias 123, 'jan_smelter'
    result.should == nil
  end

end
