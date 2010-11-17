class MessagesController < ApplicationController
    
  def index
    @messages = Message.find(:all, :conditions=>{:inbox => true, :unexpired => true, :unread => true, :notcancelled => true})
  end
  
  def show
    @message = Message.find(params[:id])
  end
  
end
