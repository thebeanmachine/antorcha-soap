
class Antorcha < ActiveRecord::Base
  attr_accessible :url
  
  def self.instance
    antorcha = Antorcha.first
    return antorcha if antorcha
    raise AntorchaConfigurationMissing, "cannot contact antorcha because no antorcha location is configured"
  end
end

class AntorchaConfigurationMissing < Exception
end