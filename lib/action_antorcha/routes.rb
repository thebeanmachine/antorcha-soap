
module ActionAntorcha
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
    
    def self.draw(&block)
      routes = Routes.new
      routes.instance_exec(&block)
      routes
    end
  end
end

