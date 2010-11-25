class Operation < ActiveRecord::Base
  include CatchUniqueConstraintViolation

  validates_uniqueness_of :message_id
  
  #after_create :post_xml  
  #after_update :put_xml
   
  after_create :enqueue_dispatch

  def enqueue_dispatch
    Delayed::Job.enqueue Jobs::DispatchOperationJob.new(id)
  end
  
  def dispatch
    message = Message.find(message_id)
    
    routes = MessageRouting.draw do
      connect :zorg_voor_jeugd, :nieuwe_signalering do |m|
        Hash.from_xml(message.body).has_key? 'nieuwe_signalering'
      end
    end

    route = routes.match message
    if route
      route.call message
    else
      raise "No route matched this message: #{message.title}"
    end
  end

end