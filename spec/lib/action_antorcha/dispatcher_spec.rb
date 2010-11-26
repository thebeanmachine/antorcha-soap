require 'spec_helper'

describe ActionAntorcha::Dispatcher do
  describe "dispatch" do
    subject {
      ActionAntorcha::Dispatcher.new mock_message
    }
    
    it "dispatches nieuwe_signalering" do
      mock_message.stub :body => '<nieuwe-signalering></nieuwe-signalering>'
      mock_service = mock(ZorgVoorJeugdService)
      ZorgVoorJeugdService.stub :new => mock_service

      mock_service.should_receive(:nieuwe_signalering).and_return('squat')
      mock_service.should_receive(:deliver)
  
      subject.dispatch
    end
  
    it "does not dispatch unknown message" do
      mock_message.stub :body => '<knippie-knaus></knippie-knaus>', :title => 'whoeps'
    
      lambda { subject.dispatch }.should raise_error(/No route matched this message: whoeps/)
    end
  end
end
