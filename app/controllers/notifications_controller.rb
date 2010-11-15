class NotificationsController < ApplicationController
  
  def create    
    Delayed::Job.enqueue(Jobs::FetchNewMessagesJob.new)
    render :text => "200"
  end

end
