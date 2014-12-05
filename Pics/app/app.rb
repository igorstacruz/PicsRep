require "sinatra"
require "sqlite3"
require "../src/db_conection"
require "../src/constants"
require "../src/Folder"
require "../src/Image"




db_pic_conection = PicDBConection.new
@@SaveSuccessfully = "..."
@@user_name = ""
enable :sessions

use Rack::Session::Cookie, 
:key => 'rack.session',
:path => '/',
:expire_after => 14400, # In seconds
:secret => 'change_me'


###### Sinatra Part ######
get "/login.html" do
    @@wrong_user_message = ""
    @@user_name = ""
    erb :login
end

get "/logout" do
    @@wrong_user_message = ""
    @@user_name = ""
    session.clear
    redirect '/login.html'
end

post '/login.html' do
    @@SaveSuccessfully = "..."
    @@user_pass_exist = db_pic_conection.does_user_with_pass_exist(params[:username], params[:password]) 
    if @@user_pass_exist == true
        session[:user_id] = params[:username] 
        @@user_name = params[:username]
        redirect '/home'
        #erb :home, :locals => {:username => params["username"]}
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
    if session[:user_id] == @@user_name
        @@user_name = params[:username]
        user_id = db_pic_conection.get_user_id(@@user_name)
        user_id = user_id.join
        @list_folder = db_pic_conection.folder_for_specific_user(user_id)
        erb :home, :locals => {:username => params["username"]}
    else
        redirect '/login.html'
    end  
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

get '/home' do
     
    @@SaveSuccessfully = "..."

    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join
    @list_folder = db_pic_conection.folder_for_specific_user(user_id)

    erb :home

end

get '/delete_image' do
     
    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join

    @list_pics = db_pic_conection.select_all_pisc_from_user(user_id)

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
    db_pic_conection.save_new_pic_user(username, email)
    @@user_name = params[:username]
    erb :home, :locals => {:username => params["username"]}
end

post '/imagetosave' do
    @image_path = params[:imagepath]
    @pic_name = params[:files]
    @folder_id = params[:folderid]
    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join

    db_pic_conection.add_image_in_databse(user_id, @folder_id, @pic_name, @image_path)
    
    db_pic_conection.read_image_from_database(user_id, @folder_id, @pic_name)

    @@SaveSuccessfully = "Image Saved"
    @list_folder = db_pic_conection.folder_for_specific_user(user_id)

    erb :home, :locals => {:username => params["username"]}
end

post '/foldertosave' do
    @folder_name = params[:foldername]
    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join

    folder_obj = Folder.new
    folder_obj.create_new_folder(@@user_name, @folder_name)

    @folder_name = @@user_name + "/" + @folder_name
    db_pic_conection.add_folder_in_databse(user_id, @folder_name)

    @@SaveSuccessfully = "..."
    @list_folder = db_pic_conection.folder_for_specific_user(user_id)

    erb :home, :locals => {:username => params["username"]}
end

post '/imagetodelete' do
    @image_code = params["imagecode"]
    user_id = db_pic_conection.get_user_id(@@user_name)
    user_id = user_id.join
    image_name = db_pic_conection.get_image_name(@image_code)
    folder_name = db_pic_conection.get_folder_name_of_specific_image(@image_code)

    db_pic_conection.delete_image_from_databse(user_id, image_name, @image_code)
    
    image_obj = Image.new
    image_obj.delete_a_specific_image(folder_name, image_name)

    @@SaveSuccessfully = "..."
    @list_folder = db_pic_conection.folder_for_specific_user(user_id)

    erb :home, :locals => {:username => params["username"]}
end

