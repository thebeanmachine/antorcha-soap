require 'spec_helper'

describe ActionAntorcha::Reply do
  subject {
    reply = ActionAntorcha::Reply.new mock_message(:request), :signaleer_iets
    reply.title "titel"
    reply.body "lichaam"
    
    reply
  }
  
  describe ".deliver" do
    before(:each) do
      mock_message(:request).stub(:effect_step_by_name).and_return(mock_step)
      
      Message.stub :create => mock_message(:reply)
      mock_message(:reply).stub :valid? => true, :deliver => true
    end
    
    it "passes title and body to message#create" do
      Message.should_receive(:create).with(hash_including(:title => 'titel', :body => 'lichaam'))
      subject.deliver
    end

    it "passes hash to serialized xml body to message#create" do
      Message.should_receive(:create).with(hash_including(:body => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<aap>\n  <noot>mies</noot>\n</aap>\n"))

      subject.body :aap => {:noot => 'mies' }
      subject.deliver
    end

    it "passes integer as body (has no to_xml) to message#create" do
      Message.should_receive(:create).with(hash_including(:body => "123"))

      subject.body 123
      subject.deliver
    end


    it "passes integer as body (has no to_xml) to message#create" do
      class CustomToXml
        def to_xml
          "eigen xml"
        end
      end
      
      Message.should_receive(:create).with(hash_including(:body => "eigen xml"))

      subject.body CustomToXml.new
      subject.deliver
    end

  
    it "passes request_id to message#create" do
      Message.should_receive(:create).with(hash_including(:request_id => mock_message(:request).id))
      subject.deliver
    end

    it "passes step_id to message#create" do
      Message.should_receive(:create).with(hash_including(:step_id => mock_step.id))
      subject.deliver
    end
    
    it "should deliver the message if message was valid" do
      mock_message(:reply).should_receive(:deliver)
      subject.deliver
    end

    it "should not deliver the message if message was valid" do
      mock_message(:reply).should_receive(:deliver)
      subject.deliver
    end
    
    it "raises 'message creation failed' if the message failed to be created in antorcha" do
      mock_message(:reply).stub :valid? => false
      mock_message(:reply).errors.stub(:full_messages)

      lambda { subject.deliver }.should raise_error(/Message creation failed:/)    
    end
  end
  
end
