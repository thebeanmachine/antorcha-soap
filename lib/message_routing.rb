module MessageRouting
  
  class Routes
    def initialize
      @routes = []
    end
  
    def connect clss, method, &block
      @routes << Route.new(clss, method, block)
    end
    
    def match message
      @routes.each do |route|
        return route if route.match? message
      end
    end
  end
  
  class Route < Struct.new(:clss_name, :method, :condition)
    def match? message
       condition.call message
    end
    
    def call message
      service(message).send method
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

