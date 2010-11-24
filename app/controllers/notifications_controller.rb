class NotificationsController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  def create    
    Delayed::Job.enqueue(Jobs::FetchNewMessagesJob.new)
    render :text => "200"
  end

end
