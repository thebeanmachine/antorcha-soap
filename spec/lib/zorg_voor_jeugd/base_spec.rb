require 'spec_helper'

describe ZorgVoorJeugd::Base do

  def organisatie_naw
    {:naam => 'Thorax', :postcode => '3800AD', :username => 'thebeanmachine'}
  end
  
  def marylin_monroe
    {
      :achternaam => 'Monroe',
      :geslacht => 'VROUW',
      :geboortedatum => '1996-06-01',
      :postcode => '5754DE',
      :huisnummer => '6'
    }
    #  	Marylin	73961486	N.J.M.	 VROUW	01-06-1996		Rokkenplein	6		5754	DE	Deurne
  end  

  describe "for hulpverlener thebeanmachine" do
    subject { ZorgVoorJeugd::Base.new  organisatie_naw}

    describe "create" do
      it "should create a signalering based on a bsn" do
        result = subject.create({ :bsn => '192139435' }, 4)
        result.status_code.should match(/0|39/)
      end

      it "should create a signalering based on jongere NAW data" do
        result = subject.create(marylin_monroe, 4)
        result.status_code.should match(/0|39/)
      end

      it "should warn about a silly bsn" do
        result = subject.create({ :bsn => '123456789' }, 4)
        result.should be_failure
      end
    end
  end
end
