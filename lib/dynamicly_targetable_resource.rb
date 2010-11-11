module DynamiclyTargetableResource
  def site
    antorcha = Antorcha.instance
    URI::parse antorcha.url
  end

  def all
    find :all
  end

  # Mockey patch
  def connection(refresh = false)
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