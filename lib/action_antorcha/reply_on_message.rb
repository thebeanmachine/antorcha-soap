module ActionAntorcha
  module ReplyOnMessage
    attr_accessor :replies

    def reply step_symbol, &block
      reply = Reply.new message, step_symbol
      reply.instance_exec(&block)
      
      @replies ||= []
      @replies << reply
    end


    def deliver
      @replies.each &:deliver if @replies
    end
  end

end