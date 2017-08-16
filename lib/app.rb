# App entry point
require_relative 'models/user'
require_relative 'persistence/connection'

db = ConnectionFactory.get_connection
user = User.new "talles@fatec.sp.gov.br", "123456"
authorized = false

configure do
  enable :sessions
end

get '/' do
  slim :index
end

post '/login' do
  @user = user if user.email == params[:email]
  if @user.passwd == params[:passwd]
    if db.get(@user.id).nil?
      # token = SecureRandom.urlsafe_base64
      db.set @user.id, [@user.id, @user.email, @user.passwd].join(',')
      session[:user_id] = @user.id
    end
    authorized = true
    redirect '/dashboard'
  end
  redirect '/'
end

get '/dashboard' do
  redirect '/' unless authorized
  @user = User.new(nil, nil)
  fields = db.get(session[:user_id]).split(',')

  @user.id = fields[0]
  @user.email = fields[1]
  @user.passwd = fields[2]

  slim :dashboard
end

get '/logout' do
  session.destroy
  authorized = false
  redirect '/'
end
