class Jobs::FetchNewMessagesJob
  def perform
    @messages = Message.all
    receive
  end
  
  def receive
    @messages.each do |message|
      Operation.create :message_id => message.id
    end
  end
  
end