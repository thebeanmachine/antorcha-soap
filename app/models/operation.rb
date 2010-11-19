class Operation < ActiveRecord::Base
  include CatchUniqueConstraintViolation

  validates_uniqueness_of :message_id

  after_create :operate
  
  def operate
  
  end
  
end
