class NotificationsController < ApplicationController
  
  def create    
    Delayed::Job.enqueue(FetchNewMessages.job.new)
  end

end
