class ZorgVoorJeugdAlias < ActiveRecord::Base
  validates_presence_of :organization_id, :organization_username
  validates_presence_of :gebruikersnaam_medewerker
  
  validates_presence_of :organisatie_naam, :organisatie_postcode, :unless => :organisatie_uuid?,
    :message => 'moet opgegeven zijn als er geen uuid is opgegeven'

  validates_presence_of :organisatie_uuid, :unless => :organisatie_naam_and_postcode?,
    :message => 'moet opgegeven zijn als er geen naam en postcode is opgegeven'
    
  validates_uniqueness_of :organization_username, :scope => :organization_id

  def self.lookup_alias organization_id, organization_username
    find :first, :conditions => { :organization_id => organization_id, :organization_username => organization_username }
  end

  def organization
    @organization ||= Organization.find(organization_id)
  end
  def organisatie_naam_and_postcode?
    organisatie_naam? && organisatie_postcode?
  end
  
  def organisatie_as_hash
    hash = {}
    hash[:naam] = organisatie_naam unless organisatie_naam.blank?
    hash[:postcode] = organisatie_postcode unless organisatie_postcode.blank?
    hash[:username] = gebruikersnaam_medewerker unless gebruikersnaam_medewerker.blank?
    hash[:uuid] = organisatie_uuid unless organisatie_uuid.blank?
    hash
  end
private

  
end
