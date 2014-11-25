require "sinatra"
require "sqlite3"
require "./src/db_conection"


db_pic_conection = PicDBConection.new
@@SaveSuccessfully = "..."

###### Sinatra Part ######
get "/login" do
    redirect "/login.html"
end

post '/login.html' do
    # TODO: Validate username and password
    @@SaveSuccessfully = "..."
    @@user_name = params[:username]
    erb :home, :locals => {:username => params["username"]}
end

get "/register" do
    redirect "/register.html"
end

post '/register*' do
    username = params[:username] 
    email = params[:email]
    #db_pic_conection = PicDBConection.new
    db_pic_conection.save_new_pic_user(username, email)
    return username + "/" + email
end

post '/imagetosave' do
    @image_path = params[:imagepath]
    @pic_name = params[:files]
    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join
    #image_obj.add_image_in_databse('userID', folderID, @image_name , @image_path)
    db_pic_conection.add_image_in_databse(user_id, '2', @pic_name, @image_path)
    @@SaveSuccessfully = "Image Saved"
    erb :home, :locals => {:username => params["username"]}
end
