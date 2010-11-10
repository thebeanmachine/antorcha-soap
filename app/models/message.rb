class Message < ActiveResource::Base
  
  fortify :title, :body
  
  def self.site
    antorcha = Antorcha.instance
    return URI::parse antorcha.url if antorcha
    raise "Not configured"
  end

  def self.all
    find :all
  end
  
  def self.connection(refresh = false)
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
