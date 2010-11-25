require 'spec_helper'

describe ActionAntorcha::ReplyOnMessage do

  class Base < Struct.new(:message)
    include ActionAntorcha::ReplyOnMessage
    
  end
  
  subject {
    Base.new mock_message(:request)
  }

  before(:each) do
    mock_message(:request).stub :effect_step_by_name => mock_step
    Message.stub :create => mock_message(:reply)
    mock_step.stub :first => mock_step
  end
  
  it "should be able to reply" do
    subject.reply :signaleer_iets do
      title "titel"
      body "lichaam"
    end
  end
  
  it "passes title and body to message#create" do
    Message.should_receive(:create).with(hash_including(:title => 'titel', :body => 'lichaam'))
    
    subject.reply :signaleer_iets do
      title "titel"
      body "lichaam"
    end
  end
  
  it "passes request_id to message#create" do
    Message.should_receive(:create).with(hash_including(:request_id => mock_message(:request).id))
    
    subject.reply :signaleer_iets do
      title "titel"
      body "lichaam"
    end
  end

  it "passes step_id to message#create" do
    Message.should_receive(:create).with(hash_including(:step_id => mock_step.id))
    
    subject.reply :signaleer_iets do
      title "titel"
      body "lichaam"
    end
  end

  it "passes successful status of the message validity as return value" do
    result = subject.reply :signaleer_iets do
      title "titel"
      body "lichaam"
    end
    
    result.should be_true
  end
 
  it "passes failure status of the message validity as return value" do
    mock_message(:reply).stub :valid? => false
    result = subject.reply :signaleer_iets do
      title "titel"
      body "lichaam"
    end
    
    result.should be_false
  end
  
end
