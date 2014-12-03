
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
            db.execute "INSERT INTO Folder(UserID, FolderName) VALUES ('1','images/admin')"
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
    
    		database = SQLite3::Database.open( "PicDB" )
    		query = "INSERT INTO User (NAME, EMAIL, PASSWORD, VAL_ACCOUNT ) VALUES (" + us_name + ", " + us_email + ", '', 0);"
    		database.execute(query)    		
    
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
    
            puts "Exception occurred"
            puts e
    
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
            return puts e
        
        ensure
            db.close if db
        end

    end

    def select_all_pisc_from_user(user_id)
        begin
    
        db = SQLite3::Database.open "PicDB.db"
        
        pics_list = db.execute "SELECT PicID, PicName FROM Picture where UserID = '" + user_id + "'"
        return pics_list
         
        rescue SQLite3::Exception => e 
    
            puts "Exception occurred"
            puts e
    
        ensure
            db.close if db
        end   
    end

    def delete_image_from_databse(user_id, pic_name)

        begin
            db = SQLite3::Database.open 'PicDB.db'
             db.execute "DELETE FROM Picture WHERE PicName = '" + pic_name + "' and UserID = '" + user_id + "'"
        
        rescue SQLite3::Exception => e
            return e
        
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

end
##### CREATE DATABASE AND INSERT DEFAULT USER Admin
#
pics = PicDBConection.new
#pics.add_folder_in_databse('1', 'Folder1')
#a = pics.folder_for_specific_user('test')
#pics.create_folder_table()
#pics.create_picture_table()
#pics.create_user_table()
pics.view_folder_table()
pics.view_image_table()
pics.view_user_table()
#pics.delete_image_from_databse('1', 'gym.jpg')
#pics.view_image_table()

