class Organization < ActiveResource::Base
  extend DynamiclyTargetableResource
  
  fortify :title
end