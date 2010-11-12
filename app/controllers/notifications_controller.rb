class NotificationsController < ApplicationController
  
  def create    
    Delayed::Job.enqueue(Jobs::FetchNewMessagesJob.new)
  end

end
