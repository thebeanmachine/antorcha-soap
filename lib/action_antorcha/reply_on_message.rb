module ActionAntorcha
  module ReplyOnMessage
    def reply step_symbol, &block
      step = find_step(step_symbol)
      raise "Step kan niet geselecteerd worden." unless step
      
      reply = Reply.new message, step.first
      reply.instance_exec(&block)
      
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
    
    def deliver
      @message = Message.create \
        :request_id => request.id, :step_id => step.id,
        :title => @title.to_s, :body => xml_serialized_body
        
      if @message.valid?
        @message.deliver
      else
        raise "Message creation failed: #{@message.errors.full_messages}"
      end
    end
    
    def xml_serialized_body
      if @body.respond_to?(:to_xml)
        if @body.kind_of?(Hash)
          root = @body.keys.first
          @body[root].to_xml :root => root
        else
          @body.to_xml
        end
      else
        @body
      end
    end
  end
end