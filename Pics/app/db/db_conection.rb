
require 'sqlite3'


class PicDBConection
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
end	

