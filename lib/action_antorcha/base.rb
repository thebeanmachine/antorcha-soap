module ActionAntorcha
  class Base
    def initialize message
      @message = message
      @params = Hash.from_xml message.body
    end

    def params
      @params
    end
    
    include ReplyOnMessage
  end
end
