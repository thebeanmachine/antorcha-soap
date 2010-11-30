require 'spec_helper'

describe ZorgVoorJeugdService do
 
  def organisatie_naw # *
    @organisatie_naw ||= {:naam => 'Thorax', :postcode => '3800AD', :username => 'thebeanmachine'}
  end

  def body
    {:bsn=>nil, :huisnummer=>nil, :geboortedatum=>nil, :signaaltype=>"4", :einddatum=>nil, :postcode=>nil, :achternaam=>nil}
  end
  
  def stub_response_is_success
    mock_zorg_voor_jeugd_response.stub \
      :success? => true,
      :status_code => '0',
      :status_omschrijving => 'banaan',
      :signaal_uuid => '12345',
      :warning? => false,
      :failure? => false
  end

  def stub_response_is_warning
    mock_zorg_voor_jeugd_response.stub \
      :success? => false,
      :status_code => '1',
      :status_omschrijving => 'peer',
      :signaal_uuid => '34567',
      :warning? => true,
      :failure? => false
  end
  
  def stub_response_is_failure
    mock_zorg_voor_jeugd_response.stub \
      :success? => false,
      :status_code => '99',
      :status_omschrijving => 'appel',
      :signaal_uuid => '67890',
      :warning? => false,
      :failure? => true
  end


  before(:each) do
    stub_new_zorg_voor_jeugd
  end
  
  describe "when the message really sucks" do
    subject do
      ZorgVoorJeugdService.new mock_message
    end
    it "should not blow up" do
      mock_message.stub :body => '<slecht></slecht>'
      subject.body.should == {}
    end
  end
  
  describe "nieuwe signalering" do
    before(:each) do
      stub_zorg_voor_jeugd_create_and_return_response
    end
    
    subject do
      mock_message.stub \
       :body => nieuwe_message_body, :organization_id => 123, :username => "jan_melder"

      ZorgVoorJeugdService.new mock_message
    end
    
    def nieuwe_message_body
      "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<nieuwe-signalering>\n  <signaaltype>4</signaaltype>\n  <huisnummer>6</huisnummer>\n  <einddatum></einddatum>\n  <postcode>5754DE</postcode>\n  <achternaam>Monroe</achternaam>\n  <bsn>73961486</bsn>\n  <geslacht>VROUW</geslacht>\n  <geboortedatum>1996-06-01</geboortedatum>\n</nieuwe-signalering>\n"
    end

    def stub_zorg_voor_jeugd_create_and_return_response
      mock_zorg_voor_jeugd.stub(:create).and_return(mock_zorg_voor_jeugd_response)
    end


   
    context "organisatie_naw can be found" do
      before(:each) do
        stub_succesful_lookup_of_aliases
      end

      context "and response was a success" do

        before(:each) do
          stub_response_is_success
        end

        it "should call create on ZorgVoorJeugd" do
          mock_zorg_voor_jeugd.should_receive(:create).with(hash_including(:postcode => '5754DE'))
          subject.nieuwe_signalering
        end

        it "should reply succesfully if response was a success (status_code == 0)" do
          subject.nieuwe_signalering

          expect_a_single_reply_message :antwoordbericht_nieuwe_signalering do |hash|
            hash[:status_code].should == '0'
          end
        end

        it "should reply with a signaal uuid if response was a success" do
          stub_response_is_success

          subject.nieuwe_signalering

          expect_a_single_reply_message :antwoordbericht_nieuwe_signalering do |hash|
            hash[:signaal_uuid].should == '12345'
          end
        end
      end
      
      context "and response with warning" do
        before(:each) do
          stub_response_is_warning
        end
   
        it "should reply with a warning (waarschuwing == true)" do
          subject.nieuwe_signalering

          expect_a_single_reply_message :antwoordbericht_nieuwe_signalering do |hash|
           hash[:waarschuwing].should == true
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
    before(:each) do
      stub_zorg_voor_jeugd_update_and_return_response
    end
    
    subject {
      mock_message.stub \
       :body => wijzig_message_body, :organization_id => 123, :username => "jan_melder"

      ZorgVoorJeugdService.new mock_message
    }
    
    def wijzig_message_body
      <<-XML
        <?xml version="1.0" encoding="UTF-8"?>
        <wijzig-signalering>
          <signaal_uuid>maak er maar een hash van</signaal_uuid>
        </wijzig-signalering>
      XML
    end
    
    
    def stub_zorg_voor_jeugd_update_and_return_response
      mock_zorg_voor_jeugd.stub(:update).and_return(mock_zorg_voor_jeugd_response)
    end

    context "organisatie_naw can be found" do
      before(:each) do
        stub_succesful_lookup_of_aliases
      end

      context "and response was a success" do
        before(:each) do
          stub_response_is_success
        end
   
        it "should call create on ZorgVoorJeugd" do
          mock_zorg_voor_jeugd.should_receive(:update).with(hash_including(:signaal_uuid=>"maak er maar een hash van"))
          subject.wijzig_signalering
        end
   
        it "should reply succesfully if response was a success (status_code == 0)" do
          subject.wijzig_signalering

          expect_a_single_reply_message :antwoordbericht_wijziging_signalering do |hash|
           hash[:status_code].should == '0'
          end
        end
      end
      
      context "and response with warning" do
        before(:each) do
          stub_response_is_warning
        end
   
        it "should reply with a warning (waarschuwing == true)" do
          subject.wijzig_signalering

          expect_a_single_reply_message :antwoordbericht_wijziging_signalering do |hash|
            hash[:waarschuwing].should == true
          end
        end
      end
      
      context "and response with failure" do
        before(:each) do
          stub_response_is_failure
        end
   
        it "should reply with a failure (failure == true)" do
          subject.wijzig_signalering

          expect_a_single_reply_message :antwoordbericht_wijziging_signalering do |hash|
            hash[:failure].should == true
          end
        end
      end
    end
    
    context "organisatie_naw cannot be found" do
      before(:each) do
        stub_failure_to_lookup_aliases
      end

      it "should reply a failure message" do
        subject.wijzig_signalering

        expect_a_single_reply_message :antwoordbericht_wijziging_signalering do |hash|
          hash[:status_code].should == '99'
          hash[:omschrijving].should =~ /niet aangemeld bij koppeling/
        end
       end
    end
  end
 
  def mock_zorg_voor_jeugd
    @mock_zorg_voor_jeugd ||= mock(ZorgVoorJeugd::Base)
  end

  def stub_new_zorg_voor_jeugd
    ZorgVoorJeugd::Base.stub :new => mock_zorg_voor_jeugd
  end
  
   
  def mock_zorg_voor_jeugd_response
    @response ||= mock(ZorgVoorJeugd::Response)
  end

  def stub_succesful_lookup_of_aliases
    ZorgVoorJeugdAlias.stub(:lookup_alias).with(123, "jan_melder").and_return(organisatie_naw)
    organisatie_naw.stub(:organisatie_as_hash).and_return(organisatie_naw)
  end

  def stub_failure_to_lookup_aliases
    ZorgVoorJeugdAlias.stub(:lookup_alias).with(123, "jan_melder").and_return(nil)
  end
 
  def expect_a_single_reply_message step_symbol, &block
    subject.replies.size.should == 1
    reply = subject.replies.first
    reply.body[step_symbol].should_not be_nil # betekend dat de step_symbol verkeerd is van de stap
    block.call reply.body[step_symbol]
  end
   
end
