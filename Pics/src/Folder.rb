require 'sinatra'
require "fileutils"

class Folder

    def create_new_folder(username, folder_name)
        new_folder = @@PICS_PATH + "images/" + username + "/" + folder_name + "/"
        puts new_folder
        FileUtils.mkpath(new_folder)
    end

    
end

#folder_obj= Folder.new
#folder_obj.create_new_folder("admin","school")

