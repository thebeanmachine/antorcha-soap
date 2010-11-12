class Operation < ActiveRecord::Base
  include CatchUniqueConstraintViolation

  validates_uniqueness_of :message_id

  after_create :operate
  
  def operate
    p "Wheeee! Let's operate something"
  end
  
end
