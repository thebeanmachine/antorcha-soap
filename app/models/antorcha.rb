
class Antorcha < ActiveRecord::Base
  attr_accessible :url
    
  validates_uniqueness_of :url
  validates_presence_of :url
  validates_format_of :url, :with => URI.regexp(['http'])
  validate_on_create :only_one_created_antorcha_allowed

  
  def self.instance
    antorcha = Antorcha.first
    return antorcha if antorcha
    raise AntorchaConfigurationMissing, "Kan geen verbinding maken met een Antorcha omdat deze niet is geconfigureerd"
  end
  
  
  private
  def only_one_created_antorcha_allowed
    errors.add_to_base 'Er is reeds een Antorcha aangemaakt.' unless Antorcha.count == 0
  end
  
end


