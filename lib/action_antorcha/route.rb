
module ActionAntorcha
  class Route < Struct.new(:clss_name, :method, :condition)
    def match? message
       condition.call message
    end
    
    def call message
      instance = service(message)
      instance.send method
      instance.deliver
    end
    
    def service message
      "#{clss_name}_service".camelize.constantize.new message
    end
  end
end

