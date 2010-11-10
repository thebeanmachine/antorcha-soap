
class Antorcha < ActiveRecord::Base
  attr_accessible :url
    
  validates_uniqueness_of :url
  validates_presence_of :url
  validates_format_of :url, :with => URI.regexp(['http']) # Should it be 'https' in the near future?
  
  def self.instance
    antorcha = Antorcha.first
    return antorcha if antorcha
    raise AntorchaConfigurationMissing, "cannot contact antorcha because no antorcha location is configured"
  end
end

class AntorchaConfigurationMissing < Exception
end