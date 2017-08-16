class ConnectionFactory

  def self.get_connection
    Redis.new(:host => 'redis', :port => 6379)
  end
end