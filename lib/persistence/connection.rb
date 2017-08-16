class ConnectionFactory

  def self.get_connection
    uri = URI.parse(ENV["REDISCLOUD_URL"])
    if uri
      Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    else
      Redis.new(:host => 'redis', :port => 6379)
    end
  end

end