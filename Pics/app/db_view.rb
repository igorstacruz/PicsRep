
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
            db.execute "INSERT INTO Folder(UserID, FolderName) VALUES ('1','tester')"
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
    		db.execute "INSERT INTO User(Name, Password) VALUES ('tester','tester123')"

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
            db.execute "INSERT INTO Folder(UserID, FolderName) VALUES ('1','tester')"
        rescue SQLite3::Exception => e
            puts "Exception Ocurred"
            puts e
        ensure
            db.close if db
        end
    end

    def create_tag_table()
        begin
            db = SQLite3::Database.open "PicDB.db"
            #db.execute "DROP TABLE Folder"
            db.execute "CREATE TABLE Tag(TagID INTEGER PRIMARY KEY, PicID INTEGER, Tag TEXT)"
        rescue SQLite3::Exception => e
            puts "Exception Ocurred"
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

    def view_tag_table()
        begin
            puts "Tag TABLE"
            db = SQLite3::Database.open "PicDB.db"
            stm = db.prepare "SELECT * FROM Tag"

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
pics.create_tag_table()

pics.view_folder_table()
pics.view_image_table()
pics.view_user_table()
pics.view_tag_table()
#folder = pics.get_folder_name_of_specific_image('2')
#puts "The folder is " + folder
#pics.read_image_from_database('1', '1', 'images.jpg')
#pics.delete_image_from_databse('1', 'gym.jpg')
#pics.view_image_table()

