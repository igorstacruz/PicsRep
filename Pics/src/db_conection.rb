
require 'sqlite3'
require 'sinatra'


class PicDBConection
	#######  CREATE DABASE METHODS #######
	
    def create_picture_table()
        begin

            db = SQLite3::Database.open "PicDB.db"
            db.execute "CREATE TABLE Picture(PicID INTEGER PRIMARY KEY, UserID INTEGER, FolderID INTEGER, PicName TEXT, Image BLOB)"
    

        rescue SQLite3::Exception => e
            puts "Exception Ocurred"
            puts e
        ensure
            db.close if db
        end
    end

    def create_folder_table()
        begin
            db = SQLite3::Database.open "PicDB.db"
            #db.execute "DROP TABLE Folder"
            db.execute "CREATE TABLE Folder(FolderID INTEGER PRIMARY KEY, UserID INTEGER, FolderName TEXT)"
    
        rescue SQLite3::Exception => e
            puts "Exception Ocurred"
            puts e
        ensure
            db.close if db
        end
    end

    def create_user_table()
        begin

            db = SQLite3::Database.open "PicDB.db"
            db.execute "CREATE TABLE User(UserID INTEGER PRIMARY KEY, Name TEXT, Email TEXT, Password TEXT, Valid_Account BOOL, Status CHAR, Last_Login DATETIME)"
    		db.execute "INSERT INTO User(Name) VALUES ('admin')"

        rescue SQLite3::Exception => e
            puts "Exception Ocurred"
            puts e
        ensure
            db.close if db
        end

    end

    #######  USER METHODS #######

	def save_new_pic_user(us_name, us_email)
		begin
    
    		db = SQLite3::Database.open "PicDB.db" 
    		query = "INSERT INTO User(Name, Email, Password, Valid_Account) VALUES ('" + us_name + "', '" + us_email + "', '', 0)"
    		db.execute(query)    		
    
		rescue SQLite3::Exception => e 
    
    		puts "Exception occurred"
    		puts e
    
		ensure
    		db.close if db
		end
		
	end

	def get_user_id(name)
        begin
    
        db = SQLite3::Database.open "PicDB.db"
        
        user_id = db.execute "SELECT UserID FROM User where Name = '" + name + "'"
        return user_id
         
        rescue SQLite3::Exception => e 
    
            return e
  
        ensure
            db.close if db
        end   
    end

    def get_user_name(user_id)
        begin
    
        db = SQLite3::Database.open "PicDB.db"
        #db.execute "CREATE TABLE User(UserID INTEGER PRIMARY KEY, Name TEXT, Email TEXT, Password TEXT, Valid_Account BOOL, Status CHAR, Last_Login DATETIME)"
        user_id = db.execute "SELECT Name FROM User where UserID = '" + user_id + "'"
        return user_id
         
        rescue SQLite3::Exception => e 
    
            return e
    
        ensure
            db.close if db
        end   
    end

    ####### IMAGE METHODS #######

    def add_image_in_databse(user_id, folder_id, pic_name='default', image)
        begin
            fin = File.open image, "rb"
            img = fin.read

        rescue SystemCallError => e
            return e
        
        ensure
            fin.close if fin
        end
        
        begin
            db = SQLite3::Database.open 'PicDB.db'
            blob = SQLite3::Blob.new img
        #    db.execute "INSERT INTO Picture (UserID, FolderID, PicName, Image)VALUES(1, ?)", blob
             db.execute "INSERT INTO Picture (UserID, FolderID, PicName, Image)VALUES(" + user_id + ", " + folder_id + ",'" + pic_name + "', ?)", blob
        
        rescue SQLite3::Exception => e
            return e        
        ensure
            db.close if db
        end

    end

    def read_image_from_database(user_id, folder_id, pic_name)

        folder_name = get_folder_name(folder_id, user_id)

        folder_path = @@PICS_PATH + "images/" + folder_name
        folder_path_with_name = folder_path + "/" + pic_name

        begin
            db = SQLite3::Database.open 'PicDB.db'
            #db.execute "CREATE TABLE Picture(PicID INTEGER PRIMARY KEY, UserID INTEGER, FolderID INTEGER, PicName TEXT, Image BLOB)"
            image = db.get_first_value "SELECT Image FROM Picture WHERE UserID = '" + user_id + "' and FolderID = '" + folder_id + "' and PicName = '" + pic_name + "' LIMIT 1"

            f = File.new folder_path_with_name, "wb"
            f.write image

        rescue SQLite3::Exception, SystemCallError => e
            return e
        ensure
            f.close if f
            db.close if db
        end
    end


    def select_all_pisc_from_user(user_id)
        begin
    
        db = SQLite3::Database.open "PicDB.db"
        
        pics_list = db.execute "SELECT PicID, PicName FROM Picture where UserID = '" + user_id + "'"
        return pics_list
         
        rescue SQLite3::Exception => e 
    
            return e
    
        ensure
            db.close if db
        end   
    end

    def delete_image_from_databse(user_id, pic_name, pic_id)

        begin
            db = SQLite3::Database.open 'PicDB.db'
             db.execute "DELETE FROM Picture WHERE PicName = '" + pic_name + "' and UserID = '" + user_id + "' and PicID = '" + pic_id + "'"
        
        rescue SQLite3::Exception => e

            return e
        
        ensure
            db.close if db
        end

    end

    def get_image_name(pic_id)
        begin    
        db = SQLite3::Database.open "PicDB.db"
        query = "select PicName from Picture where PicID ='" + pic_id + "'"
        pic_name = db.execute query
        img_name = pic_name.join
        return img_name
        rescue SQLite3::Exception => e 
    
            return puts e
    
        ensure
            db.close if db
        end
    end

    def get_folder_name_of_specific_image(pic_id)
        
        begin    
        db = SQLite3::Database.open "PicDB.db"
        query = "select FolderName from Folder, Picture where Picture.PicID ='" + pic_id + "' and Folder.FolderID = Picture.FolderID"
        folder_name = db.execute query
        f_name = folder_name.join
        return f_name
        
        rescue SQLite3::Exception => e 
    
            return e
    
        ensure
            db.close if db
        end
    end

  ####### Tag METHODS #######

    def add_tag_in_database(user_id, pic_tag)
        begin
            @pic_id= get_last_pic_id_from_user(user_id)
            @pic_id = @pic_id.join            
            db = SQLite3::Database.open 'PicDB.db'
            tags = pic_tag.split(',') 
            for tag in tags
                tag.strip
                db.execute "INSERT INTO Tag (PicID, Tag)VALUES(" + @pic_id + ", '" + tag + "')"                
            end
            #db.execute "INSERT INTO Tag (PicID, Tag)VALUES(" + pic_id + ", '" + pic_tag + "')" 
        rescue SQLite3::Exception => e
            return puts e
        
        ensure
            db.close if db
        end

    end

    def get_last_pic_id_from_user(user_id)
        begin
        db = SQLite3::Database.open "PicDB.db"
        
        pic_id = db.execute "SELECT max(PicID) FROM Picture where UserID = '" + user_id + "'"
        return pic_id
         
        rescue SQLite3::Exception => e 
    
            puts "Exception occurred"
            puts e
    
        ensure
            db.close if db
        end             
    end

    ####### FOLDER METHODS #######

    def add_folder_in_databse(user_id, name)
        begin
            db = SQLite3::Database.open 'PicDB.db'
            
        #    db.execute "INSERT INTO Folder (FolderName)VALUES(name)"
            
            db.execute "INSERT INTO Folder (UserID, FolderName)VALUES(" + user_id + ", '" + name + "')"
        
        rescue SQLite3::Exception => e
            return e
        
        ensure
            db.close if db
        end
    end

    def select_all_pics_from_user_and_specific_folder(user_id, folder_id)
        begin
    
        db = SQLite3::Database.open "PicDB.db"
        #db.execute "CREATE TABLE Picture(PicID INTEGER PRIMARY KEY, UserID INTEGER, FolderID INTEGER, PicName TEXT, Image BLOB)"
        pics_list = db.execute "SELECT PicName FROM Picture where UserID = '" + user_id + "' and FolderID = '" + folder_id + "'"
        return pics_list
         
        rescue SQLite3::Exception => e 
    
            return e
    
        ensure
            db.close if db
        end   
    end

    def folder_for_specific_user(user_id)
        begin    
        db = SQLite3::Database.open "PicDB.db"

        folder_list = db.execute "SELECT FolderID, FolderName FROM Folder where UserID = '" + user_id + "'"
        
        return folder_list 
        rescue SQLite3::Exception => e 
    
            return e
    
        ensure
            db.close if db
        end
    end

    def get_folder_name(folder_id, user_id)
        begin    
        db = SQLite3::Database.open "PicDB.db"
        folder_name = db.execute "SELECT FolderName FROM Folder where FolderID = '" + folder_id + "' and UserID = '" + user_id + "'"
        f_name = folder_name.join
        return f_name
        rescue SQLite3::Exception => e 
    
            return e
    
        ensure
            db.close if db
        end
    end

    def get_folder_id_root_of_user(user_id, user_name)
        ############################################
        #db.execute "CREATE TABLE Folder(FolderID INTEGER PRIMARY KEY, UserID INTEGER, FolderName TEXT)"
        begin    
        db = SQLite3::Database.open "PicDB.db"
        query = "select FolderID from Folder where UserID ='" + user_id + "' and FolderName = '" + user_name + "'"
        folder_name = db.execute query
        f_name = folder_name.join
        return f_name
        
        rescue SQLite3::Exception => e 
    
            return e
    
        ensure
            db.close if db
        end
    end

############################################
	def view_image_table()
		begin
			puts "IMAGE TABLE"
    		db = SQLite3::Database.open "PicDB.db"
    		stm = db.prepare "SELECT PicID, UserID, FolderID, PicName FROM Picture"

    		rs = stm.execute
    		while (row = rs.next) do
        		puts row.join "\s"
    		end

		rescue SQLite3::Exception => e
    		puts "Exception Ocurred"
    		puts e
		ensure
    		stm.close if stm
    		db.close if db
		end
	end

	def view_user_table()
		begin
			puts "USER TABLE"
    		db = SQLite3::Database.open "PicDB.db"
    		stm = db.prepare "SELECT * FROM User"

    		rs = stm.execute
    		while (row = rs.next) do
        		puts row.join "\s"
    		end

		rescue SQLite3::Exception => e
    		puts "Exception Ocurred"
    		puts e
		ensure
    		stm.close if stm
    		db.close if db
		end
	end

    def view_folder_table()
        begin
            puts "FOLDER TABLE"
            db = SQLite3::Database.open "PicDB.db"
            stm = db.prepare "SELECT * FROM Folder"

            rs = stm.execute
            while (row = rs.next) do
                puts row.join "\s"
            end

        rescue SQLite3::Exception => e
            puts "Exception Ocurred"
            puts e
        ensure
            stm.close if stm
            db.close if db
        end
    end


    # Method to verify is a user with password already exist
    # return: true: Exist  |  false: Not exist
    def does_user_with_pass_exist(name, password)

        begin

            db = SQLite3::Database.open "PicDB.db"         
            row_count = 0
            db.execute "SELECT * FROM User where Name = '" + name + "' and Password ='" + password + "'" do |row|
                row_count = row_count + 1
            end
            if row_count > 0
                return true
            else
                return false
            end    
        rescue SQLite3::Exception => e
            puts "Exception Ocurred"
            puts e
        ensure
            db.close if db
        end
    end
    
    def tag_for_specific_user(user_id)
        begin    
        db = SQLite3::Database.open "PicDB.db"

        tag_list = db.execute "SELECT tag, PicName FROM Picture where UserID = '" + user_id + "'"
        
        return tag_list 
        rescue SQLite3::Exception => e 
    
            return e
    
        ensure
            db.close if db
        end
    end


    def image_by_tag(tag, user_id)
        begin    
        db = SQLite3::Database.open "PicDB.db"

        tag_list = db.execute "SELECT PicName FROM Picture where tag = '" + tag + "' and UserID= '" + user_id + "'"
        
        return tag_list 
        rescue SQLite3::Exception => e 
    
            return e
    
        ensure
            db.close if db
        end
    end

end
