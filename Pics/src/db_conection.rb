
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
            puts "Exception ocurred"
            puts e
        
        ensure
            db.close if db
        end

    end



############################################
	def view_image_table()
		begin
			puts "IMAGE TABLE"
    		db = SQLite3::Database.open "PicDB.db"
    		stm = db.prepare "SELECT UserID, FolderID, PicName FROM Picture"

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

end
##### CREATE DATABASE AND INSERT DEFAULT USER Admin

#pics = PicDBConection.new
#pics.create_picture_table()
#pics.create_user_table()
#pics.view_image_table()
#pics.view_user_table()

