class MessagesController < ApplicationController
    
  def index
     
    @messages = Message.find(:all, :params=>{:search=>{:unexpired=>"true", :unread=>"true", :inbox=>"true", :notcancelled=>"true"}})
  end
  
  def show
    @message = Message.find(params[:id])
  end
  
end
