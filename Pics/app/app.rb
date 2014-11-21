require 'sinatra'
#require 'db/db_conection'


get "/login" do
    redirect "/login.html"
end

post '/login*' do
    username = params[:username] 
    password = params[:password]
    return username + "/" + password
end

get "/register" do
    redirect "/register.html"
end

post '/register*' do
    username = params[:username] 
    email = params[:email]
    db_pic_conection = PicDBConection.new
    db_pic_conection.save_new_pic_user(username, email)
    return username + "/" + email
end
