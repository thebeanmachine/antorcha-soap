module ActionAntorcha
  module ReplyOnMessage
    def reply step_symbol, &block
      step = find_step(step_symbol)
      raise "Step kan niet geselecteerd worden." unless step
      
      puts step.inspect
      
      reply = Reply.new message, step.first
      reply.instance_exec(&block)
      
      reply.create_message
      reply.deliver
    end
    
    
    def find_step step_symbol
      message.effect_step_by_name step_name_from_symbol(step_symbol)
    end
    
    def step_name_from_symbol step_symbol
      step_symbol.to_s.gsub('_','-')
    end
  end
  
  class Reply < Struct.new(:request, :step)
    def title title
      @title = title
    end
    def body body
      @body = body
    end
    
    def create_message
      @message = Message.create \
        :request_id => request.id, :step_id => step.id,
        :title => @title.to_s, :body => xml_serialized_body
    end
    
    def deliver
      #@message.deliver
      url_for Antorcha.url/messages/@message.id/deliveries
    end
    
    def xml_serialized_body
      if @body.respond_to?(:to_xml)
        @body.to_xml
      else
        @body
      end
    end
  end
end