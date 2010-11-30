module ActionAntorcha
  class Base
    include ReplyOnMessage
    
    def initialize message
      @message = message
      begin
        @params = Hash.from_xml message.body
      rescue Exception => e
        #
        # Known bug: There is no way to communicate default errors back to antorcha.
        # Solution: Aggreement on de default exception step.
        #
        
        puts "Could not parse message, probably silly xml: #{e.message}"
        @params = {}
      end
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
