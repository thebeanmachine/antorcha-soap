require 'spec_helper'

describe ActionAntorcha::ReplyOnMessage do

  class Base < Struct.new(:message)
    include ActionAntorcha::ReplyOnMessage
    
  end
  
  subject {
    Base.new mock_message(:request)
  }

  before(:each) do
    #mock_message(:request).stub :effect_step_by_name => mock_step
    Message.stub :create => mock_message(:reply)
    mock_message(:reply).stub :valid? => true, :deliver => true
    mock_step.stub :first => mock_step
  end
  
  describe ".reply" do
    it "should create a reply object and store it" do
      subject.reply :signaleer_iets do
        title "titel"
        body "lichaam"
      end
    
      subject.replies.first.should == ActionAntorcha::Reply.new(mock_message(:request), :signaleer_iets)
    end

    it "should assign the body and title" do
      subject.reply :signaleer_iets do
        title "titel"
        body "lichaam"
      end
    
      subject.replies.first.title.should == "titel"
      subject.replies.first.body.should == "lichaam"
    end
  end
  
  describe ".deliver" do
    it "should deliver nothing if there are no replies" do
      subject.deliver
    end

    it "should deliver the reply" do
      mock_reply = mock(ActionAntorcha::Reply)
      ActionAntorcha::Reply.stub :new => mock_reply
      
      subject.reply :hippie do end
      
      mock_reply.should_receive :deliver
      subject.deliver
    end

  end
  
end
