require File.dirname(__FILE__) + '/../spec_helper'

describe NotificationsController do
  
  it "should be notified" do
    post :create
    p "Wat zeggie?"
  end
  
end