class Message < ActiveResource::Base
  extend DynamiclyTargetableResource
  
  fortify :title, :body
  

end
