require 'sqlite3'
database = SQLite3::Database.open( "PicDB" )
 
database.execute( "CREATE TABLE USER(ID INT PRIMARY KEY      NOT NULL,
   NAME           TEXT     NOT NULL,
   EMAIL          TEXT     NOT NULL,
   PASSWORD       CHAR(50),
   VAL_ACCOUNT    BOOLEAN
   STATUS         TEXT     
   LAST_LOGIN     TEXT     
);" )
 
#database.execute( "insert into sample_table (sample_text,sample_number) values ('Sample Text1', 123)")
#database.execute( "insert into sample_table (sample_text,sample_number) values ('Sample Text2', 456)")
 
rows = database.execute( "select * from USER" )
 
p rows