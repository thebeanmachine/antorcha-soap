module ActionAntorcha
  class Base
    include ReplyOnMessage
    
    def initialize message
      @message = message
      @params = Hash.from_xml message.body
      @body = Hash.from_xml message.body
    end

    def params
      @params
    end

    def body
      @body["hash"].symbolize_keys!
    end
    
    def message
      @message
    end
  end
end
