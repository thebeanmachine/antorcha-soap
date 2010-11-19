class NotificationsController < ApplicationController
  
  protect_from_forgery :except => :create

  
  def create
    logger.info("*** PSSSSSST!! :) ***")
    Delayed::Job.enqueue(Jobs::FetchNewMessagesJob.new)
    render :text => "200"
  end

end
