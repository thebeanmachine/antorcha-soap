class Jobs::FetchNewMessagesJob
  def perform
   new_messages = Message.all  # We probably should filter this, so we do not fetch all messages but only the new ones.
   new_messages.each do |new_message|
    Operation.create :message_id => new_message.id
   end
  end
end