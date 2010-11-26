class Operation < ActiveRecord::Base
  include CatchUniqueConstraintViolation

  validates_uniqueness_of :message_id
   
  after_create :enqueue_dispatch

  def enqueue_dispatch
    Delayed::Job.enqueue Jobs::DispatchOperationJob.new(id)
  end
  
  def dispatch
    message = Message.find(message_id)
    ActionAntorcha::Dispatcher.new(message).dispatch
  end

end