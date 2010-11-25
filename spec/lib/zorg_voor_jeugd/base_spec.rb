require 'spec_helper'

  def organisatie_naw # *
    {:naam => 'Thorax', :postcode => '3800AD', :username => 'thebeanmachine'}
  end
  
  def jongere_naw_required_fields # *
    {:geboortedatum => '1996-06-01', :geslacht => 'VROUW', :postcode => '5754DE', :huisnummer => '6'}
  end
  
  def jongere_naw_optional_fields
    {:achternaam => 'Monroe'}
  end
  
  def signaaltype # *
    {:signaaltype => rand(4)+1}
  end
  
  def einddatum
    {:einddatum => "2012-12-21"}
  end
  
  def bsn # *
    {:bsn => '73961486'}
  end
    
  def required_fields
    jongere_naw_required_fields.merge signaaltype
  end
  
  describe ZorgVoorJeugd::Base do    
    
    describe "create" do
      context "with valid 'organisatie_naw'" do
        
        subject { ZorgVoorJeugd::Base.new organisatie_naw }
        
        context "and with an minimum of the required and valid fields" do
          it "should create and match the status code '0' or '39'" do
            result = subject.create required_fields
            result.status_code.should match(/0|39/)
          end
          
          it "should create a signalering based on a bsn" do
            result = subject.create(bsn.merge signaaltype)
            result.status_code.should match(/0|39/)
          end
        end
        
        it "should create a signalering" do
          result = subject.create(jongere_naw_required_fields.merge(jongere_naw_optional_fields).merge(signaaltype).merge(einddatum))
          result.status_code.should match(/0|39/)
        end    
        
        context "and with invalid fields" do
          it "should warn about a silly bsn" do
            result = subject.create({ :bsn => '123456789', :signaaltype => '1' })
            result.should be_failure
          end
          
          it "should raise an error about a wrong date" do
            result = subject.create required_fields.merge(:einddatum => "12-21-2012")
            result.response[:status_code].should == 99
          end
        end
  
      end
      
      context "with invalid 'organisatie_naw'" do
        subject { ZorgVoorJeugd::Base.new :naam => 'Foo', :postcode => '0000AA', :username => 'foo-user' }
        
        it "should raise status code 99" do
          result =  subject.create required_fields
          result.response[:status_code].should == 99
        end
      end
    end
    
  end