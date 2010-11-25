class Delivery < ActiveResource::Base
  extend DynamiclyTargetableResource
  
  # def site
  #     antorcha = Antorcha.instance
  #     URI::parse antorcha.url+"/messages/:message_id"
  #   end
  #   
  #   def message
  #     Message.find(self.prefix_options[:message_id])
  #   end
  #  
  #   def message=(message)
  #     self.prefix_options[:message_id] = message.id
  #   end

end
