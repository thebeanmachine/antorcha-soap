require 'spec_helper'

describe ZorgVoorJeugdService do
 
  def organisatie_naw # *
   {:naam => 'Thorax', :postcode => '3800AD', :username => 'snagel'}
  end
  
  def message_body
   "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<nieuwe-signalering>\n  <signaaltype>4</signaaltype>\n  <huisnummer>6</huisnummer>\n  <einddatum></einddatum>\n  <postcode>5754DE</postcode>\n  <achternaam>Monroe</achternaam>\n  <bsn>73961486</bsn>\n  <geslacht>VROUW</geslacht>\n  <geboortedatum>1996-06-01</geboortedatum>\n</nieuwe-signalering>\n"
  end
 
  subject {
    mock_message.stub \
     :body => message_body, :organization_id => "1", :username => "henk"
    ZorgVoorJeugdService.new mock_message
  } 
   
  describe "nieuwe signalering" do
   
   it "should reply with success" do    
    
    response = mock(ZorgVoorJeugd::Response)
    response.stub(:success?).and_return(true)
    
    response.stub :status_code => 99, :status_omschrijving => 'Whoeps'
    
    signalering = mock(ZorgVoorJeugd::Base)
    signalering.stub :create => response

    ZorgVoorJeugd::Base.stub :new => signalering
    
    subject.nieuwe_signalering
    
    subject.replies.each do |r|
     puts "-" * 80
     puts r.step_symbol
     puts r.title
     puts r.body.inspect
     puts r.xml_serialized_body
     r.title.should == "Gesignaleerd"
     r.step_symbol.should == :antwoordbericht_nieuwe_signalering
     r.body[:nieuwe_signalering][:status_code].should == 99
    end
    
   end
   
   it "should reply with a warning" do    
    
    response = mock(ZorgVoorJeugd::Response)
   
   response.stub(:success?).and_return(false)
    response.stub(:warning?).and_return(true)
    
    response.stub :status_code => 99, :status_omschrijving => 'Whoeps'
    
    signalering = mock(ZorgVoorJeugd::Base)
    signalering.stub :create => response

    ZorgVoorJeugd::Base.stub :new => signalering
    
    subject.nieuwe_signalering
    
    subject.replies.each do |r|
     puts "-" * 80
     puts r.step_symbol
     puts r.title
     puts r.body.inspect
     puts r.xml_serialized_body
     r.title.should == "Gesignaleerd, echter met een waarschuwing"
     r.step_symbol.should == :antwoordbericht_nieuwe_signalering
     r.body[:nieuwe_signalering][:waarschuwing].should == true
    end
    
   end
   
   it "should reply with an failure of some kind" do    
    
    response = mock(ZorgVoorJeugd::Response)
   
   response.stub(:success?).and_return(false)
    response.stub(:warning?).and_return(false)
    
    response.stub :status_code => 99, :status_omschrijving => 'Whoeps'
    
    signalering = mock(ZorgVoorJeugd::Base)
    signalering.stub :create => response

    ZorgVoorJeugd::Base.stub :new => signalering
    
    subject.nieuwe_signalering
    
    subject.replies.each do |r|
     r.title.should == "Signalering mislukt"
     r.step_symbol.should == :antwoordbericht_nieuwe_signalering
     r.body[:nieuwe_signalering][:failure].should == true
    end
    
   end 
   
  end
end
