module MessageRouting
  
  class Routes
    def initialize
      @routes = []
    end
  
    def connect clss, method, &block
      @routes << Route.new(clss, method, block)
    end
    
    def match message
      @routes.detect do |route|
        route.match? message
      end
    end
  end
  
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

  def self.draw(&block)
    routes = Routes.new
    routes.instance_exec(&block)
    routes
  end
  
end

