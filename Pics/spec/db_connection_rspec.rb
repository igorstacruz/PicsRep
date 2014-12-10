require 'db_conection'
require 'Folder'
require "fileutils"
require "constants"


describe "User" do

    it "should return the user_id given a name" do
        usr_obj = PicDBConection.new()
        user_name = usr_obj.get_user_id('tester')
        user_name = user_name.join
        expect(user_name).to eq '1'
    end

    it "should return an empty value when send a username that is not stored in database" do
        usr_obj = PicDBConection.new()
        user_name = usr_obj.get_user_id('InvalidUser')
        user_name = user_name.join
        expect(user_name).to eq ''
    end

    it "should return the user name given a user id" do
        usr_obj = PicDBConection.new()
        user_name = usr_obj.get_user_name('1')
        user_name = user_name.join
        expect(user_name).to eq 'tester'
    end

    it "should return an empty value when send a user id that is not stored in database" do
        usr_obj = PicDBConection.new()
        user_name = usr_obj.get_user_id('100')
        user_name = user_name.join
        expect(user_name).to eq ''
    end

end


describe "Image" do
    it "should add an image in the database when send a correct image path" do
        img = PicDBConection.new()
        image_path = @@PICS_PATH + "images/gym.jpg"
        img.add_image_in_databse('1','2','test.jpg',image_path)
        begin
    		db = SQLite3::Database.open "PicDB.db"
    		stm = db.prepare "SELECT PicName FROM Picture where PicName = 'test.jpg'"

    		rs = stm.execute
    		while (row = rs.next) do
        		exp = row.join
    		end

		rescue SQLite3::Exception => e
    		puts "Exception Ocurred"
    		puts e
		ensure
    		stm.close if stm
    		db.close if db
		end
        expect(exp).not_to eq nil
    end

    it "should return an exception when try to add an image with incorrect image path" do
        img = PicDBConection.new()
        image_path = @@PICS_PATH + "images/incorrect.jpg"
        e = img.add_image_in_databse('1','2','test_invalid.jpg',image_path)
        e = e.to_s
        exception_expected = "No such file or directory - " + @@PICS_PATH + "images/incorrect.jpg"
        
        expect(e).to eq exception_expected
    end

    it "should read an image from the database" do
        img = PicDBConection.new()
        img.read_image_from_database('1', '1', 'test.jpg')

        expected_image = @@PICS_PATH + "images/tester/test.jpg"
        expect(File.exists? expected_image).not_to eq false
        FileUtils.rm expected_image

    end

    it "should return a zero when try to read an image that does not exist from the database" do
        img = PicDBConection.new()
        e = img.read_image_from_database('1', '1', 'wrong_img.jpg')
        e = e.to_s
        exception_expected = "0"
        expect(e).to eq exception_expected
        expected_image = @@PICS_PATH + "images/tester/wrong_img.jpg"
        FileUtils.rm expected_image

    end

    it "should delete an image from the database when send a correct image path" do
        img = PicDBConection.new()
        image_path = @@PICS_PATH + "images/gym.jpg"
        img.add_image_in_databse('1','2','test_delete.jpg',image_path)
        begin
            db = SQLite3::Database.open "PicDB.db"
            stm = db.prepare "SELECT PicID FROM Picture where PicName = 'test_delete.jpg' and UserID='1'"

            rs = stm.execute
            while (row = rs.next) do
                pic_id = row.join
            end

        rescue SQLite3::Exception => e
            puts "Exception Ocurred"
            puts e
        ensure
            stm.close if stm
            db.close if db
        end
        img.delete_image_from_databse('1', 'test_delete.jpg',pic_id)

        begin
            db = SQLite3::Database.open "PicDB.db"
            stm = db.prepare "SELECT PicName FROM Picture where PicName = 'test_delete.jpg'"

            rs = stm.execute
            while (row = rs.next) do
                exp = row.join
            end

        rescue SQLite3::Exception => e
            puts "Exception Ocurred"
            puts e
        ensure
            stm.close if stm
            db.close if db
        end
        expect(exp).to eq nil
    end

    it "should return all the images from the database that belong a specific user" do
        img = PicDBConection.new()
        image_path = @@PICS_PATH + "images/gym.jpg"
        img.add_image_in_databse('1','2','test1.jpg',image_path)
        image_list = img.select_all_pisc_from_user('1')
        
        expect(image_list).not_to eq nil
    end

    it "should return all the images from the database that belong a specific user and specific folder" do
        img = PicDBConection.new()
        image_path = @@PICS_PATH + "images/gym.jpg"
        img.add_image_in_databse('1','2','test1.jpg',image_path)
        image_list = img.select_all_pics_from_user_and_specific_folder('1','1')
        
        expect(image_list).not_to eq nil
    end

    it "should return the image name given a image id" do
        img = PicDBConection.new()
        image_name = img.get_image_name('1')
        
        expect(image_name).not_to eq nil
    end
end

describe "Folder" do

    it "should add a folder record in database when send correct values" do
        folder_obj = PicDBConection.new()
        folder_obj.add_folder_in_databse('1','TestFolder')
        begin
            db = SQLite3::Database.open "PicDB.db"
            stm = db.prepare "SELECT FolderName FROM Folder where FolderName = 'TestFolder'"

            rs = stm.execute
            while (row = rs.next) do
                exp = row.join
            end

        rescue SQLite3::Exception => e
            puts "Exception Ocurred"
            puts e
        ensure
            stm.close if stm
            db.close if db
        end
        expect(exp).not_to eq nil
    end

    it "should return all the folder that belong to a specific user" do
        folder_obj = PicDBConection.new()
        folder_list = folder_obj.folder_for_specific_user('1')

        expect(folder_list).not_to eq nil

    end

    it "should return an exception when try to save a new folder record on DB with invalid values" do
        folder_obj = PicDBConection.new()
        e = folder_obj.add_folder_in_databse('Invalid','TestInvalid')
        e = e.to_s
        exception_expected = "no such column: Invalid"
        
        expect(e).to eq exception_expected
        
    end

    it "should create a new folder in the expected path" do
        folder = Folder.new

        folder.create_new_folder('tester', 'NewTest')
        expected_directory = @@PICS_PATH + "images/tester/NewTest"

        expect(File.directory? expected_directory).not_to eq false
        FileUtils.rmdir expected_directory
    end

    it "should return the folder name for a specific recordID" do
        folder_obj = PicDBConection.new()
        folder_name = folder_obj.get_folder_name('1','1')

        expect(folder_name).to eq 'tester'
    end

    it "should return the folder name for a specific image" do
        folder_obj = PicDBConection.new()
        
        image_path = @@PICS_PATH + "images/gym.jpg"
        folder_obj.add_image_in_databse('1','1','gym.jpg',image_path)

        folder_name = folder_obj.get_folder_name_of_specific_image('1')

        expect(folder_name).to eq 'TestFolder'
    end

    it "should return an empty value given an invalid image code" do
        folder_obj = PicDBConection.new()
        
        folder_name = folder_obj.get_folder_name_of_specific_image('100')

        expect(folder_name).to eq ''
    end

    it "should return the default folder id for a specific user" do
       folder_obj = PicDBConection.new()
        
        folder_id = folder_obj.get_folder_id_root_of_user('1','tester')

        expect(folder_id).to eq '1' 
    end
end

describe "Tag" do

    it "should add an single tag for image" do
        img = PicDBConection.new()
        image_path = @@PICS_PATH + "images/gym.jpg"
        img.add_image_in_databse('1','2','test1.jpg',image_path)
        tags = "test_tag"
        img.add_tag_in_database('1', tags)
        pic_id= img.get_last_pic_id_from_user('1')
        pic_id = pic_id.join 
        number_tags = img.number_of_tags_for_image(pic_id)
        
        expect(number_tags).to eq '1'
    end

    it "should add multiple tags for image" do
        img = PicDBConection.new()
        image_path = @@PICS_PATH + "images/gym.jpg"
        img.add_image_in_databse('1','2','test1.jpg',image_path)
        tags = "test_tag,Test2,Test3"
        img.add_tag_in_database('1', tags)
        pic_id= img.get_last_pic_id_from_user('1')
        pic_id = pic_id.join 
        number_tags = img.number_of_tags_for_image(pic_id)
        
        expect(number_tags).to eq '3'
    end

end