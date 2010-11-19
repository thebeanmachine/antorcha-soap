class MessagesController < ApplicationController
    
  def index
    #Sorry doesn't work that way: @messages = Message.find(:all, :conditions=>{:inbox => true, :unexpired => true, :unread => true, :notcancelled => true})
    @messages = Message.all
  end
  
  def show
    @message = Message.find(params[:id])
  end
  
end
