class Message < ActiveResource::Base
  extend DynamiclyTargetableResource
  
  fortify :title, :body

  def effect_step_by_name name
    Step.find_effect_step_for_message_by_name self, name
  end
  
  def deliver
    @delivery = Delivery.create :message_id => id
    raise "Bericht kon niet verstuurd worden: #{@delivery.errors.full_messages}" unless @delivery.valid?
    true
  end
end
