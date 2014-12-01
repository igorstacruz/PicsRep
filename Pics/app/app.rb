require "sinatra"
require "sqlite3"
require "./src/db_conection"
require "./src/constants"
require "./src/Folder"




db_pic_conection = PicDBConection.new
@@SaveSuccessfully = "..."
@folder_list = [["test1", 1], ["test2", 0]]

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

get '/home' do
     
    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join
    @folder_list = db_pic_conection.folder_for_specific_user(user_id)
    puts @folder_list
    puts @folder_list.class
    erb :home

end

get "/register" do
    redirect "/register.html"
end

get "/create_folder" do
    #redirect "/create_folder.html"
    erb :folder, :locals => {:username => params["username"]}
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
    @folder_id = params[:folderid]
    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join
    #image_obj.add_image_in_databse('userID', folderID, @image_name , @image_path)
    db_pic_conection.add_image_in_databse(user_id, @folder_id, @pic_name, @image_path)
    @@SaveSuccessfully = "Image Saved"
    erb :home, :locals => {:username => params["username"]}
end

post '/foldertosave' do
    @folder_name = params[:foldername]
    puts @folder_name
    #@pic_name = params[:files]
    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join
    #image_obj.add_image_in_databse('userID', folderID, @image_name , @image_path)
    folder_obj = Folder.new
    folder_obj.create_new_folder(@@user_name, @folder_name)
    db_pic_conection.create_folder_table()
    db_pic_conection.add_folder_in_databse(user_id, @folder_name)

    #@@SaveSuccessfully = "Image Saved"

    erb :home, :locals => {:username => params["username"]}
end
