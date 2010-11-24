module ActionAntorcha
  class Base
    def initialize message
      @message = message
      @params = Hash.from_xml message.body
      @body = Hash.from_xml message.body
    end

    def params
      @params
    end

    def body
      @body.symbolize_keys!
      @body[:hash]
    end
    
    def message
      @message
    end
    
    include ReplyOnMessage
  end
end
