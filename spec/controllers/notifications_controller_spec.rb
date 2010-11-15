require File.dirname(__FILE__) + '/../spec_helper'

describe NotificationsController do
  
  context "with GET create" do
    it "should create a new delayed job" do
      mock_delayed_job = mock_model(Delayed::Job)
      mock_delayed_job.stub(:enqueue).with(Jobs::FetchNewMessagesJob)      
      post :create
      response.should have_text("200")
    end
  end
end