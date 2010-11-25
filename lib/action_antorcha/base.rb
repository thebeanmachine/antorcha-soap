module ActionAntorcha
  class Base
    include ReplyOnMessage
    
    def initialize message
      @message = message
      @params = Hash.from_xml message.body
    end

    def params
      @params
    end
    
    def message
      @message
    end
    
    def username
      @message.username
    end
    
    def organization_id
      @message.organization_id
    end
  end
end
