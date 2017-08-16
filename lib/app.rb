# App entry point
require_relative 'models/user'
require_relative 'persistence/connection'

db = ConnectionFactory.get_connection
user = User.new "talles@fatec.sp.gov.br", "lalalala"
authorized = false

get '/' do
  slim :index
end

post '/login' do
  if user.is_equal?(User.new(params[:email], params[:passwd]))
    if db.get(user.id).nil?
      token = SecureRandom.urlsafe_base64
      db.set user.id, token
    end
    authorized = true
    redirect '/dashboard'
  end
  redirect '/'
end

get '/dashboard' do
  redirect '/' unless authorized
  "It works"
end

get '/logout' do
  u = db.get user.id
  db.del u.id
  redirect '/'
end
