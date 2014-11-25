require 'db_conection'

describe "Image" do
    it "should add an image in the database when send a correct image path" do
        img = PicDBConection.new()
        image_path = "C:/Pics3/Pics/features/images_test/gym.jpg"
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
        image_path = "C:/Pics3/Pics/features/images_test/incorrect.jpg"
        e = img.add_image_in_databse('1','2','test_invalid.jpg',image_path)
        e = e.to_s
        exception_expected = "No such file or directory - C:/Commit/Pics/features/images_test/incorrect.jpg"
        
        expect(e).to eq exception_expected
    end
end

