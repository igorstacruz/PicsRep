require "sinatra"
require "sqlite3"
require "../src/db_conection"
require "../src/constants"
require "../src/Folder"




db_pic_conection = PicDBConection.new
@@SaveSuccessfully = "..."


###### Sinatra Part ######
get "/login.html" do
    @@wrong_user_message = ""
    @@user_name = ""
    erb :login
end

post '/login.html' do
    @@SaveSuccessfully = "..."
    @@user_pass_exist = db_pic_conection.does_user_with_pass_exist(params[:username], params[:password]) 
    if @@user_pass_exist == true
        @@user_name = params[:username]
        erb :home, :locals => {:username => params["username"]}
    else 
        @@wrong_user_message = "Usuario o Password incorrectos"        
        erb :login
    end      
end

get '/home' do
     
    #user_id = db_pic_conection.get_user_id(@@user_name)
    #user_id = user_id.join
    #@folder_list = db_pic_conection.folder_for_specific_user(user_id)
    #puts @folder_list
    #puts @folder_list.class
    @@SaveSuccessfully = "..."
    erb :home

end

get '/delete_image' do
     
    puts @@user_name
    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join
    puts user_id
    @list_pics = db_pic_conection.select_all_pisc_from_user(user_id)
    puts @list_pics
    puts @list_pics.class
    #@folder_list = db_pic_conection.folder_for_specific_user(user_id)
    #puts @folder_list
    #puts @folder_list.class
    @@SaveSuccessfully = "..."
    erb :delete_image

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
    #db_pic_conection.create_folder_table()
    db_pic_conection.add_folder_in_databse(user_id, @folder_name)

    @@SaveSuccessfully = "..."

    erb :home, :locals => {:username => params["username"]}
end

post '/imagetodelete' do
    @image_name = params["imagename"]
    puts @image_name
    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join
    puts user_id
    db_pic_conection.delete_image_from_databse(user_id, @image_name)
    @@SaveSuccessfully = "..."
    erb :home, :locals => {:username => params["username"]}
end

