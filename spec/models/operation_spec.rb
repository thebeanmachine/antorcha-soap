require 'spec_helper'

describe Operation do
  before(:each) do
    @valid_attributes = {
      :message_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Operation.create!(@valid_attributes)
  end

  it "should validate uniqueness" do
    Operation.create! :message_id => 1
    o = Operation.create :message_id => 1
    o.errors.on(:message_id).should =~ /is niet beschikbaar/
  end

  it "should validate uniqueness even if it hits the database unique index" do
    Operation.create! :message_id => 1
    o = Operation.create! :message_id => 2
    o.update_attribute :message_id, 1
    o.errors.on(:message_id).should =~ /reeds in gebruik/
  end

end
