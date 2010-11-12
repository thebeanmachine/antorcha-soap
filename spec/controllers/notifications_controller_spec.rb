require File.dirname(__FILE__) + '/../spec_helper'

describe NotificationsController do
  
  context "with GET create"
  it "should create a new delayed job" do
    Delayed::Job.should_receive(:enqueue).with(Jobs::FetchNewMessagesJob.new)
    post :create
  end
  
end