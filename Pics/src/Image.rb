require 'sinatra'
require "fileutils"

class Image

    def delete_a_specific_image(folder_name, pic_name)

        expected_image = @@PICS_PATH + "images/" + folder_name + "/" + pic_name
        puts expected_image
        FileUtils.rm expected_image
    end

    
end


