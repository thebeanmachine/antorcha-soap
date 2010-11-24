class Step < ActiveResource::Base
  extend DynamiclyTargetableResource
  
  fortify :name

  def self.find_effect_step_for_message_by_name message, name
    Step.find :all, :from => "/messages/#{message.to_param}/steps.xml", :params => { :name => name }
  end

end
