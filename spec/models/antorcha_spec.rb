require File.dirname(__FILE__) + '/../spec_helper'

describe Antorcha do
  it "should be valid" do
    Antorcha.new.should be_valid
  end
end
