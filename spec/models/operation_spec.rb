require 'spec_helper'

describe Operation do
  before(:each) do
    @valid_attributes = {
      :message_id => 1
    }
    
    Message.stub :find => mock_message
    
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
  
  describe "dispatch" do
    it "dispatches nieuwe_signalering" do
      mock_message.stub :body => '<nieuwe-signalering></nieuwe-signalering>'
      mock_service = mock(ZorgVoorJeugdService)
      ZorgVoorJeugdService.stub :new => mock_service
      mock_service.should_receive(:nieuwe_signalering).and_return('squat')
      Operation.create!(@valid_attributes).dispatch
    end
    
    it "does not dispatch unknown message" do
      mock_message.stub :body => '<knippie-knaus></knippie-knaus>', :title => 'whoeps'
      
      lambda { Operation.create!(@valid_attributes).dispatch }.should raise_error(/No route matched this message: whoeps/)
    end
  end

end
