require 'spec_helper'

describe ZorgVoorJeugdService do
 
  def organisatie_naw # *
   {:naam => 'Thorax', :postcode => '3800AD', :username => 'thebeanmachine'}
  end
  
  def message_body
   "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<nieuwe-signalering>\n  <signaaltype>4</signaaltype>\n  <huisnummer>6</huisnummer>\n  <einddatum></einddatum>\n  <postcode>5754DE</postcode>\n  <achternaam>Monroe</achternaam>\n  <bsn>73961486</bsn>\n  <geslacht>VROUW</geslacht>\n  <geboortedatum>1996-06-01</geboortedatum>\n</nieuwe-signalering>\n"
  end
  
  def body
   {:bsn=>nil, :huisnummer=>nil, :geboortedatum=>nil, :signaaltype=>"4", :einddatum=>nil, :postcode=>nil, :achternaam=>nil}
  end
  
 
  subject {
    mock_message.stub \
     :body => message_body, :organization_id => 123, :username => "jan_melder"
    
    ZorgVoorJeugdService.new mock_message
  }
  
  describe "nieuwe signalering" do
   
   def mock_zorg_voor_jeugd
     @mock_zorg_voor_jeugd ||= mock(ZorgVoorJeugd::Base)
   end

   def stub_new_zorg_voor_jeugd
     ZorgVoorJeugd::Base.stub :new => mock_zorg_voor_jeugd
   end
   
   def stub_zorg_voor_jeugd_create_and_return_response
     mock_zorg_voor_jeugd.stub(:create).and_return(mock_zorg_voor_jeugd_response)
   end
   
   def mock_zorg_voor_jeugd_response
     @response ||= mock(ZorgVoorJeugd::Response)
   end

   def stub_succesful_lookup_of_aliases
     ZorgVoorJeugdAlias.stub(:lookup_alias).with(123, "jan_melder").and_return(organisatie_naw)
     organisatie_naw = lookup.stub(:organisatie_as_hash).and_return(organisatie_naw)
   end

   def stub_failure_to_lookup_aliases
     ZorgVoorJeugdAlias.stub(:lookup_alias).with(123, "jan_melder").and_return(nil)
   end

   def stub_response_is_succes
     mock_zorg_voor_jeugd_response.stub \
      :success? => true,
      :status_code => '0',
      :status_omschrijving => 'banaan',
      :signaal_uuid => '12345',
      :warning? => false,
      :failure? => false
   end
   
   def expect_a_single_reply_message step_symbol, &block
     subject.replies.size.should == 1
     reply = subject.replies.first
     reply.body[step_symbol].should_not be_nil # betekend dat de step_symbol verkeerd is van de stap
     block.call reply.body[step_symbol]
   end
   

   before(:each) do
     stub_new_zorg_voor_jeugd
     stub_zorg_voor_jeugd_create_and_return_response
   end
   
   context "organisatie_naw can be found" do
     before(:each) do
       stub_succesful_lookup_of_aliases
     end
     
     context "and response was a success" do

       before(:each) do
         stub_response_is_succes
       end
    
       it "should reply succesfully if response was a success (status_code == 0)" do
        
        subject.nieuwe_signalering
   
        expect_a_single_reply_message :antwoordbericht_nieuwe_signalering do |hash|
          hash[:status_code].should == '0'
        end
       end
   
       it "should reply with a signaal uuid if response was a success" do
        stub_response_is_succes
        
        subject.nieuwe_signalering
   
        expect_a_single_reply_message :antwoordbericht_nieuwe_signalering do |hash|
          hash[:signaal_uuid].should == '12345'
        end
       end
    end

   end

   context "organisatie_naw cannot be found" do
     before(:each) do
       stub_failure_to_lookup_aliases
     end
     
     it "should reply a failure message" do
       subject.nieuwe_signalering
    
       expect_a_single_reply_message :antwoordbericht_nieuwe_signalering do |hash|
         hash[:status_code].should == '99'
         hash[:omschrijving].should =~ /niet aangemeld bij koppeling/
       end
      end
 
   end
  
  end
  
  describe "wijzig signalering" do
   it "should reply anyway" do
    pending
    lookup = mock(ZorgVoorJeugdAlias)
    lookup.stub(:lookup_alias).with(123, "jan_melder")
    find_organisatie_naw = lookup.stub(:organisatie_as_hash).and_return(organisatie_naw)
    subject.stub(:find_organisatie_naw).and_return(find_organisatie_naw)
    subject.stub(:organisatie_naw).and_return(find_organisatie_naw)
    
    subject.wijzig_signalering
    
    subject.replies.each do |r|
     puts r.step_symbol
     puts r.title
     puts r.body.inspect
     puts r.xml_serialized_body
    end
   end
  end

end

  describe "wijzig signalering" do
   it "should reply with success" do    
    
    response = mock(ZorgVoorJeugd::Response)
    response.stub(:success?).and_return(true)
    response.stub(:warning?).and_return(false)
    response.stub(:failure?).and_return(false)
    
    response.stub :status_code => 99, :status_omschrijving => 'Whoeps', :signaal_uuid => '97523'
    
    signalering = mock(ZorgVoorJeugd::Base)
    signalering.stub :update => response
 
    ZorgVoorJeugd::Base.stub :new => signalering
    
    subject.wijzig_signalering
    
    subject.replies.each do |r|
     puts "-" * 80
     puts r.step_symbol
     puts r.title
     puts r.body.inspect
     puts r.xml_serialized_body
     r.title.should == "Gesignaleerd"
     r.step_symbol.should == :antwoordbericht_nieuwe_signalering
     r.body[:nieuwe_signalering][:status_code].should == 99
     r.body[:nieuwe_signalering][:waarschuwing].should == false
     r.body[:nieuwe_signalering][:failure].should == false
    end
    
   end
  end
   
   
  describe "nieuwe signalering" do
   
   it "should reply with success" do    
    
    response = mock(ZorgVoorJeugd::Response)
    response.stub(:success?).and_return(true)
    response.stub(:warning?).and_return(false)
    response.stub(:failure?).and_return(false)
    
    response.stub :status_code => 99, :status_omschrijving => 'Whoeps', :signaal_uuid => '97523'
    
    signalering = mock(ZorgVoorJeugd::Base)
    signalering.stub :create => response
 
    ZorgVoorJeugd::Base.stub :new => signalering
    
   it "should create a 'signalering'" do
    subject.nieuwe_signalering
    subject.replies.each do |reply|
     p "-" * 20
     p reply.step_symbol
     p reply.title
     p reply.body.inspect
    end
   end
   
   it "should update a 'signalering'" do
    pending
    subject.wijzig_signalering
   end
 
   it "should reply with success" do    
    
    response = mock(ZorgVoorJeugd::Response)
    response.stub(:success?).and_return(true)
    response.stub(:warning?).and_return(false)
    response.stub(:failure?).and_return(false)
    
    response.stub :status_code => 99, :status_omschrijving => 'Whoeps', :signaal_uuid => '97523'
    
    signalering = mock(ZorgVoorJeugd::Base)
    signalering.stub :create => response
   
    ZorgVoorJeugd::Base.stub :new => signalering
    
    subject.nieuwe_signalering
    
    subject.replies.each do |r|
     puts "-" * 80
     puts r.step_symbol
     puts r.status_code
     puts r.title
     puts r.body.inspect
     puts r.xml_serialized_body
     #r.title.should == "Gebruiker en organisatie niet aangemeld bij koppeling"
    end
    
   end
   
   it "should reply with a warning" do    
    
    response = mock(ZorgVoorJeugd::Response)
   
    response.stub(:success?).and_return(false)
    response.stub(:warning?).and_return(true)
    response.stub(:failure?).and_return(false)
   
    response.stub :status_code => 39, :status_omschrijving => 'Whoeps', :signaal_uuid => '97523'
    
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
     r.body[:nieuwe_signalering][:failure].should == false
    end
    
   end
   
   it "should reply with an failure of some kind" do    
    
    response = mock(ZorgVoorJeugd::Response)
   
    response.stub(:success?).and_return(false)
    response.stub(:warning?).and_return(false)
    response.stub(:failure?).and_return(true)
    
    response.stub :status_code => 99, :status_omschrijving => 'Whoeps', :signaal_uuid => nil
    
    signalering = mock(ZorgVoorJeugd::Base)
    signalering.stub :create => response
   
    ZorgVoorJeugd::Base.stub :new => signalering
    
    subject.nieuwe_signalering
    
    subject.replies.each do |r|
     r.title.should == "Signalering mislukt"
     r.step_symbol.should == :antwoordbericht_nieuwe_signalering
     r.body[:nieuwe_signalering][:waarschuwing].should == false
     r.body[:nieuwe_signalering][:failure].should == true
    end
    
   end 
   
  end
end
