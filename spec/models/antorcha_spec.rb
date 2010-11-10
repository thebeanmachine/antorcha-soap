require File.dirname(__FILE__) + '/../spec_helper'

describe Antorcha do

  %w(http://abc.example.net http://).each do |valid_argument|
    context "with an url argument '#{valid_argument}'" do
      it "should be valid" do
        Antorcha.new(:url => valid_argument).should be_valid
      end
    end
  end  
   
  %w(ftp://abc.example.net abc.example.net abc example.net https://top.secret.net).each do |invalid_argument|
    context "with an url argument '#{invalid_argument}'" do      
      it "should be invalid" do
        Antorcha.new(:url => invalid_argument).should be_invalid
      end      
    end    
  end

  context "without an url argument" do    
    it "should be invalid" do
      Antorcha.new.should be_invalid
    end
  end
  
  context "with an url argument that is identical" do    
    it "should be invalid" do
      Antorcha.create(:url => "http://identical.example.net")
      Antorcha.new(:url => "http://identical.example.net").should be_invalid
    end
  end
  
  context "with an url argument http:///oeps.test.net" do
    it "should be invalid. But..." do
      pending "We must modify the Regular Expression so that the argument 'http:///' also is invalid!"
    end
  end
  
end
