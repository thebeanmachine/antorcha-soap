require File.dirname(__FILE__) + '/../spec_helper'

describe MessagesController do
  it "index action should render index template" do
    Message.stub :find => mock_messages
    get :index
    response.should render_template(:index)
  end

  it "index action should find message with specific conditions." do
    Message.should_receive(:find).with(:all, :params=>{:search=>{:unexpired=>"true", :unread=>"true", :inbox=>"true", :notcancelled=>"true"}}).and_return(mock_messages)
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    stub_find mock_message
    get :show, :id => mock_message.to_param
    response.should render_template(:show)
  end
end
