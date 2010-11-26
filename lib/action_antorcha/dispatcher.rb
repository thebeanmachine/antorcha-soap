
module ActionAntorcha
  class Dispatcher < Struct.new(:message)
    def dispatch
      routes = Routes.draw do
        connect :zorg_voor_jeugd, :nieuwe_signalering do |m|
          Hash.from_xml(m.body).has_key? 'nieuwe_signalering'
        end
        connect :zorg_voor_jeugd, :wijzig_signalering do |m|
          Hash.from_xml(m.body).has_key? 'wijzig_signalering'
        end
      end

      route = routes.match message
      if route
        route.call message
      else
        raise "No route matched this message: #{message.title}"
      end
    end
  end
end
