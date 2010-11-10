require File.dirname(__FILE__) + '/../spec_helper'

describe MessagesController do
  it "index action should render index template" do
    stub_all mock_messages
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    stub_find mock_message
    get :show, :id => mock_message.to_param
    response.should render_template(:show)
  end
end
