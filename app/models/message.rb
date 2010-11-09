class Message < ActiveResource::Base
  
  def self.site
    puts Antorcha.first.url
    URI::parse Antorcha.first.url
  end

  def self.all
    find :all
  end
  
  def self.connection(refresh = false)
    puts "OW JA? #{site}"
    #if defined?(@connection) || superclass == Object
      @connection = ActiveResource::Connection.new(site, format) if refresh || @connection.nil?
      @connection.proxy = proxy if proxy
      @connection.user = user if user
      @connection.password = password if password
      @connection.timeout = timeout if timeout
      @connection.ssl_options = ssl_options if ssl_options
      @connection
    #else
    #  superclass.connection
    #end
  end

end
