# App entry point

redis = Redis.new(:host => 'redis', :port => 6379)
redis.set "test", "Yolo"

get '/' do
  @message = redis.get "test"
  slim :index
end