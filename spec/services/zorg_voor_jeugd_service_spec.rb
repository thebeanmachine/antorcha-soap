require 'spec_helper'

describe ZorgVoorJeugdService do
 
  def organisatie_naw # *
   {:naam => 'Thorax', :postcode => '3800AD', :username => 'snagel'}
  end
  
  def message_body
   "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<hash>\n  <signaaltype>4</signaaltype>\n  <huisnummer>6</huisnummer>\n  <einddatum></einddatum>\n  <postcode>5754DE</postcode>\n  <achternaam>Monroe</achternaam>\n  <bsn>73961486</bsn>\n  <geslacht>VROUW</geslacht>\n  <geboortedatum>1996-06-01</geboortedatum>\n</hash>\n"
  end

 
  subject {
    mock_message.stub :body => message_body
    ZorgVoorJeugdService.new mock_message
  } 
   
  describe "nieuwe signalering" do
   
   it "should convert the body with XML to a Hash" do
    result = subject.body
    result.kind_of?(Hash).should be_true
   end
   
   it "should response to 'nieuwe_signalering'" do
    signalering = ZorgVoorJeugd::Base.new organisatie_naw
    result = signalering.stub(:create).with(subject.body)
   end
   
  end
end
