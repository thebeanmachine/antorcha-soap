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
end
