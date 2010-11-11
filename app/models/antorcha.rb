
class Antorcha < ActiveRecord::Base
  attr_accessible :url
    
  validates_uniqueness_of :url
  validates_presence_of :url
  validates_format_of :url, :with => URI.regexp(['http'])
  validate :only_one_antorcha_allowed

  
  def self.instance
    antorcha = Antorcha.first
    return antorcha if antorcha
    raise AntorchaConfigurationMissing, "cannot contact antorcha because no antorcha location is configured"
  end
  
  def only_one_antorcha_allowed
    errors.add_to_base 'Er is reeds een antorcha aangemaakt.' unless Antorcha.count == 0
  end
  
end

class AntorchaConfigurationMissing < Exception
end