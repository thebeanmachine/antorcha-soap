require File.dirname(__FILE__) + '/../spec_helper'

describe NotificationsController do
  
  context "with POST create" do
    it "should create a new delayed job" do
      mock_delayed_job = mock_model(Delayed::Job)
      mock_delayed_job.stub(:enqueue).with(Jobs::FetchNewMessagesJob)
      post :create
      response.should have_text("200")
    end
    
    it "should not have the verify_authenticity_token before filter" do
      controller.class.before_filters.should_not include(:verify_authenticity_token)
    end
  end
  
  
end