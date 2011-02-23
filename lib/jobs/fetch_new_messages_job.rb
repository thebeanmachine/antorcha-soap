class Jobs::FetchNewMessagesJob
  def perform
    @messages = Message.find(:all, :params=>{:search=>{:unexpired=>"true", :unread=>"true", :inbox=>"true", :notcancelled=>"true"}})
    receive
  end
  
  def receive
    @messages.each do |message|
      Operation.create(:message_id => message.id, :message_title => message.title)
    end
  end
  
end