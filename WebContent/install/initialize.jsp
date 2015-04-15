<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%@page import="org.apache.derby.jdbc.EmbeddedConnectionPoolDataSource40" %>
<%@page import="com.puzzlemall.database.ConnectionManager" %>
<%@page import="com.puzzlemall.constants.DatabaseConstants" %>
<%@page import="com.puzzlemall.constants.SystemConstants" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Installing...</title>
</head>
<body>

<%
if (request.getParameter("username") == null
	&& request.getParameter("password") == null	) {
%>
	<b><u>Installation</u></b><br>
	Please provide the credentials of the root mysql database user:<br>
	<form name="frmInstallInput" id="frmInstallInput" action="initialize.jsp" method="POST">
		username: <input type="text" name="username" id="username" value="root"><br>
		password: <input type="password" name="password" id="password"><br>
		host: <input type="text" name="host" id="host" value="localhost"><br>
		port: <input type="text" name="port" id="port" value="3306"><br>
		<input type=submit value="submit">
	</form>
<%
} else {
	int installMySQL = 1;
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String host = request.getParameter("host");
	int port = 0;
	try {
		port = Integer.parseInt(request.getParameter("port"));
	} catch (Exception e){throw e;}
	
	if(username == null || password == null || host == null || port == 0) {
		installMySQL = 0;
	} else if(username.length() == 0|| password.length() == 0|| host.length() == 0){
		installMySQL = 0;
	}
	
	//************************
	//** Derby Install Code **
	//************************
	
	out.println("<u><b>Installing apache derby DB...</b></u><br>");
	
	try {
		//Initial creation of an apache derby database
		String databaseName = DatabaseConstants.DERBY_DATABASE_NAME;
		EmbeddedConnectionPoolDataSource40 dataSource = 
				new EmbeddedConnectionPoolDataSource40();
		dataSource.setDatabaseName(databaseName);
		dataSource.setCreateDatabase("create");
		dataSource.setLogWriter(new PrintWriter(System.out));
		dataSource.getConnection();
		
		out.println("Database Created Successfuly <br>");
		System.out.println("Database Created Successfuly\n");
	} catch (Exception e) {
		out.println(e.toString());
	}
	
	Connection conn = null;
	try {
		conn = ConnectionManager.getDerbyConnection();
		
		String SqlString = null;
		String SqlString2 = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		
		//#########################
		//## User Table Creation ##
		//#########################
		
		try {
			//drop previous table if exists
			SqlString = "DROP TABLE users";
			pstmt = conn.prepareStatement(SqlString);	
		 	result = pstmt.executeUpdate(); 
	 		out.println("Previous User Table Erased Successfuly <br>");
	 		System.out.println("Previous User Table Erased Successfuly \n");
		} catch(Exception e) {
			//do nothing
		}
		
		//user role: customer - able to register, recover password, manage profile, view & buy puzzles
		//user role: supplier - able to recover password, manage profile, view total stock
		//user role: manager - able to recover password, manage profile, view total stock, manage products
		
		//create user table
		SqlString = 
	          "CREATE TABLE users "
	        + "(username VARCHAR(41) NOT NULL CONSTRAINT USER_PK PRIMARY KEY, "
	        + "password VARCHAR(41) NOT NULL, "
	        + "recoveryQuestion VARCHAR(151) NOT NULL, "
	        + "recoveryAnswer VARCHAR(51) NOT NULL, "
	        + "role VARCHAR(26) NOT NULL, "
	        + "email VARCHAR(51) NOT NULL, "
	        + "cellphone VARCHAR(26) NOT NULL, "
	        + "address VARCHAR(151) NOT NULL, "
	        + "creditcard VARCHAR(17) NOT NULL)";
		
		pstmt = conn.prepareStatement(SqlString);	
		result = pstmt.executeUpdate();
	 		 
	 	out.println("User Table Created Successfuly <br>");
	 	System.out.println("User Table Created Successfuly\n");
	 	
	 	//insert users
	 	SqlString2 = 
	          "INSERT INTO users "
	        + "(username,password,recoveryQuestion,recoveryAnswer,role," 
	         + "email,cellphone,address,creditcard) "
	        + "VALUES" 
	        + "('admin', 'superlongpass12321'," 
	         + "'What is the Ultimate Answer to the Ultimate Question of Life, The Universe, and Everything?'," 
	         + "'42','" + SystemConstants.ADMIN_ROLE 
	         + "','admin@puzzlemall.com','010203424242'," 
	         + "'nowhere', '4242424242424242')";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
		
		SqlString2 = 
	          "INSERT INTO users "
	        + "(username,password,recoveryQuestion,recoveryAnswer,role," 
	         + "email,cellphone,address,creditcard) "
	        + "VALUES" 
	        + "('user1', 'guessme12321'," 
	         + "'What is the Magic Word?'," 
	         + "'NOW','" + SystemConstants.CUSTOMER_ROLE 
	         + "','user1@someone.com','010203123456'," 
	         + "'someday', '1234123412341234')";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
		
		SqlString2 = 
	          "INSERT INTO users "
	        + "(username,password,recoveryQuestion,recoveryAnswer,role," 
	         + "email,cellphone,address,creditcard) "
	        + "VALUES" 
	        + "('user2', 'guessme32123'," 
	         + "'Who is your daddy?'," 
	         + "'Jupiter','" + SystemConstants.CUSTOMER_ROLE 
	         + "','user2@nasaland.com','010203134340'," 
	         + "'Pluto', '4321432143214321')";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
		
		SqlString2 = 
	          "INSERT INTO users "
	        + "(username,password,recoveryQuestion,recoveryAnswer,role," 
	         + "email,cellphone,address,creditcard) "
	        + "VALUES" 
	        + "('user3', 'guessme11111'," 
	         + "'What is your favorite metal?'," 
	         + "'Banana','" + SystemConstants.SUPPLIER_ROLE 
	         + "','user3@madmonkey.com','010203611980'," 
	         + "'Pluto', '1111111111111111')";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
	 	
		out.println("Users Created Successfuly <br>");
	 	System.out.println("Users Created Successfuly\n");
		
	 	//###########################
		//## Puzzle Table Creation ##
		//###########################
		
		try {
			//drop previous table if exists
			SqlString = "DROP TABLE puzzles";
			pstmt = conn.prepareStatement(SqlString);	
		 	result = pstmt.executeUpdate(); 
	 		out.println("Previous Puzzles Table Erased Successfuly <br>");
	 		System.out.println("Previous Puzzles Table Erased Successfuly \n");
		} catch(Exception e) {
			//do nothing
		}
		
		//create puzzle table
		SqlString = 
	          "CREATE TABLE puzzles "
	        + "(puzzleid INT NOT NULL GENERATED ALWAYS AS IDENTITY " 
	                           + "CONSTRAINT PUZZLE_PK PRIMARY KEY, "
	         + "puzzlename VARCHAR(25) NOT NULL, "
	         + "imagename VARCHAR(50) NOT NULL, "
	         + "stock INT NOT NULL DEFAULT 0, "
	         + "price INT NOT NULL DEFAULT 100)";
		
		pstmt = conn.prepareStatement(SqlString);	
		result = pstmt.executeUpdate();
	 		 
	 	out.println("Puzzle Table Created Successfuly <br>");
	 	System.out.println("Puzzle Table Created Successfuly\n");
	 	
	 	//insert puzzles
	 	SqlString2 = 
	          "INSERT INTO puzzles "
	        + "(puzzlename,imagename,price,stock) " 
	        + "VALUES('Blue Puzzle','bluepuzzle_icon.jpg',500,5000)";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
		
	 	SqlString2 = 
	          "INSERT INTO puzzles "
	        + "(puzzlename,imagename,price,stock) " 
	        + "VALUES('Gray Puzzle','graypuzzle_icon.jpg',300,3000)";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
		
		SqlString2 = 
	          "INSERT INTO puzzles "
	        + "(puzzlename,imagename,price,stock) " 
	        + "VALUES('Colorful Puzzle','colorfulpuzzle_icon.jpg',550,700)";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
	 	
		out.println("Puzzles Created Successfuly <br>");
	 	System.out.println("Puzzles Created Successfuly\n");
	 	
	 	
	 	//###########################
		//## Orders Table Creation ##
		//###########################
		
		try {
			//drop previous table if exists
			SqlString = "DROP TABLE orders";
			pstmt = conn.prepareStatement(SqlString);	
		 	result = pstmt.executeUpdate(); 
	 		out.println("Previous Orders Table Erased Successfuly <br>");
	 		System.out.println("Previous Orders Table Erased Successfuly \n");
		} catch(Exception e) {
			//do nothing
		}
		
		//create orders table
		SqlString = 
	          "CREATE TABLE orders "
	        + "(orderid INT NOT NULL GENERATED ALWAYS AS IDENTITY " 
	                           + "CONSTRAINT ORDER_PK PRIMARY KEY, "
	         + "puzzleid INT NOT NULL, "
	         + "username VARCHAR(25) NOT NULL, "
	         + "quantity INT NOT NULL)";
		
		pstmt = conn.prepareStatement(SqlString);	
		result = pstmt.executeUpdate();
	 		 
	 	out.println("Orders Table Created Successfuly <br>");
	 	System.out.println("Orders Table Created Successfuly\n");
	 	
	 	//insert orders
	 	SqlString2 = 
	          "INSERT INTO orders "
	        + "(puzzleid,username,quantity) " 
	        + "VALUES(1,'user1',1)";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
		
	 	SqlString2 = 
	 		  "INSERT INTO orders "
	        + "(puzzleid,username,quantity) " 
	        + "VALUES(1,'user2',1)";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
		
		SqlString2 = 
	 		  "INSERT INTO orders "
	        + "(puzzleid,username,quantity) " 
	        + "VALUES(3,'user2',1)";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
		
		SqlString2 = 
			  "INSERT INTO orders "
	        + "(puzzleid,username,quantity) " 
	        + "VALUES(2,'user1',1)";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
	 	
		out.println("Default Orders Created Successfuly <br>");
	 	System.out.println("Default Orders Created Successfuly\n");
	 	
	 	
	 	//################################
		//## MySQLConfig Table Creation ##
		//################################
		
		try {
			//drop previous table if exists
			SqlString = "DROP TABLE mysqlconfig";
			pstmt = conn.prepareStatement(SqlString);	
		 	result = pstmt.executeUpdate(); 
	 		out.println("Previous Puzzles Table Erased Successfuly <br>");
	 		System.out.println("Previous Puzzles Table Erased Successfuly \n");
		} catch(Exception e) {
			//do nothing
		}
		
		//create mysqlconfig table
		SqlString = 
	          "CREATE TABLE mysqlconfig "
	        + "(id INT NOT NULL CONSTRAINT MySQLID_PK PRIMARY KEY, " +
	           "useMySQL INT NOT NULL DEFAULT 0, host VARCHAR(50) NOT NULL, port INT NOT NULL DEFAULT 0)";
		
		pstmt = conn.prepareStatement(SqlString);	
		result = pstmt.executeUpdate();
	 		 
	 	out.println("MySQLConfig Table Created Successfuly <br>");
	 	System.out.println("MySQLConfig Table Created Successfuly\n");
	 	
	 	//insert mysqlconfig
	 	SqlString2 = 
	          "INSERT INTO mysqlconfig "
	        + "(id,useMySQL,host,port) " 
	        + "VALUES(1,0,'" + host + "'," + port + ")";
	 	pstmt = conn.prepareStatement(SqlString2);
		result = pstmt.executeUpdate();
	 	
		out.println("mysqlconfig Created Successfuly <br>");
	 	System.out.println("mysqlconfig Created Successfuly\n");
	 	
		conn.close();
		
		conn = null;
	
	//------------------------------------------------------------------------
	
	
	
	
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	
	
	
	
	//************************
	//** MySQL Install Code **
	//************************
	    if (installMySQL == 1) {
		
	    	out.println("<u><b>Installing mysql DB...</b></u><br>");
	    	
		    String rootConnectionString =
        	    "jdbc:mysql://" + host + ":" + port +
        	    "/information_schema?user=" + username + "&password=" + password;
		
		    /* Test loading driver */
	        String driver = DatabaseConstants.DATABASE_DRIVER;
            Class.forName(driver).newInstance();
    
            /* Test the connection */
            conn = DriverManager.getConnection(rootConnectionString);
        
            //#############################
		    //## MySQL Database Creation ##
		    //#############################
		
			try {
				//drop previous database if exists
				SqlString = "drop database IF EXISTS " + DatabaseConstants.DATABASE_NAME;
				pstmt = conn.prepareStatement(SqlString);	
			 	result = pstmt.executeUpdate(); 
		 		out.println("Previous MySQL Database Dropped Successfuly <br>");
		 		System.out.println("Previous MySQL Database Dropped Successfuly \n");
			} catch(Exception e) {
				//do nothing
			}
			
			//create/re-create the mysql database
			SqlString = 
		          "create database " + DatabaseConstants.DATABASE_NAME;
			
			pstmt = conn.prepareStatement(SqlString);	
			result = pstmt.executeUpdate();
		 		 
		 	out.println("MySQL Database Created Successfuly <br>");
		 	System.out.println("MySQL Database Created Successfuly\n");
			
		 	//close connections in order to switch DB with using the "use" clause
		 	try {
        		conn.close();
		 	} catch(Exception err){}
		 
		 	
		 	rootConnectionString =
        	    "jdbc:mysql://" + host + ":" + port +
        	    "/" + DatabaseConstants.DATABASE_NAME + 
        	    "?user=" + username + "&password=" + password;
		
		    /* Test loading driver */
	        driver = DatabaseConstants.DATABASE_DRIVER;
            Class.forName(driver).newInstance();
    
            /* Test the connection */
            conn = DriverManager.getConnection(rootConnectionString);
		 	
			
			//#########################
			//## User Table Creation ##
			//#########################
			
			try {
				//drop previous table if exists
				SqlString = "DROP TABLE IF EXISTS users";
				pstmt = conn.prepareStatement(SqlString);	
			 	result = pstmt.executeUpdate(); 
		 		out.println("Previous User Table Erased Successfuly - MySQL <br>");
		 		System.out.println("Previous User Table Erased Successfuly - MySQL\n");
			} catch(Exception e) {
				//do nothing
			}
			
			//user role: customer - able to register, recover password, manage profile, view & buy puzzles
			//user role: supplier - able to recover password, manage profile, view total stock
			//user role: manager - able to recover password, manage profile, view total stock, manage products
			
			//create user table
			SqlString = 
		          "CREATE TABLE users "
		        + "(username VARCHAR(41) NOT NULL, PRIMARY KEY (username), "
		        + "password VARCHAR(41) NOT NULL, "
		        + "recoveryQuestion VARCHAR(151) NOT NULL, "
		        + "recoveryAnswer VARCHAR(51) NOT NULL, "
		        + "role VARCHAR(26) NOT NULL, "
		        + "email VARCHAR(51) NOT NULL, "
		        + "cellphone VARCHAR(26) NOT NULL, "
		        + "address VARCHAR(151) NOT NULL, "
		        + "creditcard VARCHAR(17) NOT NULL)";
			
			pstmt = conn.prepareStatement(SqlString);	
			result = pstmt.executeUpdate();
		 		 
		 	out.println("User Table Created Successfuly - MySQL<br>");
		 	System.out.println("User Table Created Successfuly - MySQL\n");
		 	
		 	//insert users
		 	SqlString2 = 
		          "INSERT INTO users "
		        + "(username,password,recoveryQuestion,recoveryAnswer,role," 
		         + "email,cellphone,address,creditcard) "
		        + "VALUES" 
		        + "('admin', 'superlongpass12321'," 
		         + "'What is the Ultimate Answer to the Ultimate Question of Life, The Universe, and Everything?'," 
		         + "'42','" + SystemConstants.ADMIN_ROLE 
		         + "','admin@puzzlemall.com','010203424242'," 
		         + "'nowhere', '4242424242424242')";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
			
			SqlString2 = 
		          "INSERT INTO users "
		        + "(username,password,recoveryQuestion,recoveryAnswer,role," 
		         + "email,cellphone,address,creditcard) "
		        + "VALUES" 
		        + "('user1', 'guessme12321'," 
		         + "'What is the Magic Word?'," 
		         + "'NOW','" + SystemConstants.CUSTOMER_ROLE 
		         + "','user1@someone.com','010203123456'," 
		         + "'someday', '1234123412341234')";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
			
			SqlString2 = 
		          "INSERT INTO users "
		        + "(username,password,recoveryQuestion,recoveryAnswer,role," 
		         + "email,cellphone,address,creditcard) "
		        + "VALUES" 
		        + "('user2', 'guessme32123'," 
		         + "'Who is your daddy?'," 
		         + "'Jupiter','" + SystemConstants.CUSTOMER_ROLE 
		         + "','user2@nasaland.com','010203134340'," 
		         + "'Pluto', '4321432143214321')";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
			
			SqlString2 = 
		          "INSERT INTO users "
		        + "(username,password,recoveryQuestion,recoveryAnswer,role," 
		         + "email,cellphone,address,creditcard) "
		        + "VALUES" 
		        + "('user3', 'guessme11111'," 
		         + "'What is your favorite metal?'," 
		         + "'Banana','" + SystemConstants.SUPPLIER_ROLE 
		         + "','user3@madmonkey.com','010203611980'," 
		         + "'Pluto', '1111111111111111')";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
		 	
			out.println("Users Created Successfuly <br>");
		 	System.out.println("Users Created Successfuly\n");
			
		 	//###########################
			//## Puzzle Table Creation ##
			//###########################
			
			try {
				//drop previous table if exists
				SqlString = "DROP TABLE IF EXISTS puzzles";
				pstmt = conn.prepareStatement(SqlString);	
			 	result = pstmt.executeUpdate(); 
		 		out.println("Previous Puzzles Table Erased Successfuly  - MySQL<br>");
		 		System.out.println("Previous Puzzles Table Erased Successfuly  - MySQL\n");
			} catch(Exception e) {
				//do nothing
			}
			
			//create puzzle table
			SqlString = 
		          "CREATE TABLE puzzles "
		        + "(puzzleid INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(puzzleid), " 
		         + "puzzlename VARCHAR(25) NOT NULL, "
		         + "imagename VARCHAR(50) NOT NULL, "
		         + "stock INT NOT NULL DEFAULT 0, "
		         + "price INT NOT NULL DEFAULT 100)";
			
			pstmt = conn.prepareStatement(SqlString);	
			result = pstmt.executeUpdate();
		 		 
		 	out.println("Puzzle Table Created Successfuly - MySQL<br>");
		 	System.out.println("Puzzle Table Created Successfuly - MySQL\n");
		 	
		 	//insert puzzles
		 	SqlString2 = 
		          "INSERT INTO puzzles "
		        + "(puzzlename,imagename,price,stock) " 
		        + "VALUES('Blue Puzzle','bluepuzzle_icon.jpg',500,5000)";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
			
		 	SqlString2 = 
		          "INSERT INTO puzzles "
		        + "(puzzlename,imagename,price,stock) " 
		        + "VALUES('Gray Puzzle','graypuzzle_icon.jpg',300,3000)";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
			
			SqlString2 = 
		          "INSERT INTO puzzles "
		        + "(puzzlename,imagename,price,stock) " 
		        + "VALUES('Colorful Puzzle','colorfulpuzzle_icon.jpg',550,700)";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
		 	
			out.println("Puzzles Created Successfuly <br>");
		 	System.out.println("Puzzles Created Successfuly\n");
		 	
		 	
		 	//###########################
			//## Orders Table Creation ##
			//###########################
			
			try {
				//drop previous table if exists
				SqlString = "DROP TABLE IF EXISTS orders";
				pstmt = conn.prepareStatement(SqlString);	
			 	result = pstmt.executeUpdate(); 
		 		out.println("Previous Orders Table Erased Successfuly  - MySQL<br>");
		 		System.out.println("Previous Orders Table Erased Successfuly  - MySQL\n");
			} catch(Exception e) {
				//do nothing
			}
			
			//create orders table
			SqlString = 
		          "CREATE TABLE orders "
		        + "(orderid INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(orderid), " 
		         + "puzzleid INT NOT NULL, "
		         + "username VARCHAR(25) NOT NULL, "
		         + "quantity INT NOT NULL)";
			
			pstmt = conn.prepareStatement(SqlString);	
			result = pstmt.executeUpdate();
		 		 
		 	out.println("Orders Table Created Successfuly  - MySQL<br>");
		 	System.out.println("Orders Table Created Successfuly - MySQL\n");
		 	
		 	//insert orders
		 	SqlString2 = 
		          "INSERT INTO orders "
		        + "(puzzleid,username,quantity) " 
		        + "VALUES(1,'user1',1)";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
			
		 	SqlString2 = 
		 		  "INSERT INTO orders "
		        + "(puzzleid,username,quantity) " 
		        + "VALUES(1,'user2',1)";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
			
			SqlString2 = 
		 		  "INSERT INTO orders "
		        + "(puzzleid,username,quantity) " 
		        + "VALUES(3,'user2',1)";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
			
			SqlString2 = 
				  "INSERT INTO orders "
		        + "(puzzleid,username,quantity) " 
		        + "VALUES(2,'user1',1)";
		 	pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
		 	
			out.println("Default Orders Created Successfuly - MySQL<br>");
		 	System.out.println("Default Orders Created Successfuly - MySQL\n");
		 	
		 	
		 	//###########################
		 	//##Dedicated User Creation##
		 	//###########################
		 	try {
				//drop previous table if exists
				SqlString = "DROP USER '" + DatabaseConstants.USERNAME + "'@'localhost';";
				pstmt = conn.prepareStatement(SqlString);	
			 	result = pstmt.executeUpdate(); 
		 		out.println("Previous MySQL User Account Erased Successfuly  - MySQL<br>");
		 		System.out.println("Previous MySQL User Account Successfuly  - MySQL\n");
			} catch(Exception e) {
				//do nothing
			}
			
			//create a dedicated mysql user account
			SqlString = 
		          "CREATE USER '" + DatabaseConstants.USERNAME + "'@'localhost' " +
		          "IDENTIFIED BY '" + DatabaseConstants.PASSWORD + "';";
			
			pstmt = conn.prepareStatement(SqlString);	
			result = pstmt.executeUpdate();
			
			//grant privileges to the mysql user account
			SqlString = 
				  "GRANT ALL PRIVILEGES ON " + DatabaseConstants.DATABASE_NAME + 
				  ".* to '" + DatabaseConstants.USERNAME + "'@'localhost';";
			
			pstmt = conn.prepareStatement(SqlString);	
			result = pstmt.executeUpdate();
		 		 
		 	out.println("MySQL User Account Created Successfuly  - MySQL<br>");
		 	System.out.println("MySQL User Account Created Successfuly - MySQL\n");
	
	
	//-------------------------------------------------------------------------
	 	
		 	//close connections in order to switch DB with using the "use" clause
		 	try {
        		conn.close();
		 	} catch(Exception err){}
		 		
	 		//***********************************
			//** POST Installation Config Code **
			//***********************************
			
			conn = ConnectionManager.getDerbyConnection();
			
	 		//if all was successful - use mysql (define in derby DB)
		
			//insert a new line to the table with useMySQL flag set 1
			//delete the previous row before (workaround for a bug in derby)
			SqlString2 = 
	          	"DELETE FROM mysqlconfig "
	        	+ "WHERE id=1";
	 		pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
		
			out.println("previous mysqlconfig rows deleted <br>");
	 		System.out.println("previous mysqlconfig deleted\n");
		
	 		SqlString2 = 
	          	"INSERT INTO mysqlconfig "
	        	+ "(id,useMySQL,host,port) " 
	        	+ "VALUES(2,1,'" + host + "'," + port + ")";
	 		pstmt = conn.prepareStatement(SqlString2);
			result = pstmt.executeUpdate();
	 	
			out.println("mysqlconfig rows replaced, the application will use mysql as the DB <br>");
	 		System.out.println("mysqlconfig rows replaced, the application will use mysql as the DB\n");
	 	
	 	}
	 	
	 	//-----------------------------------------------------
		out.flush();
		
		if(conn != null) {
	    	ConnectionManager.closeConnection(conn);
	    }
	} catch (Exception e) {
		if(conn != null) {
    		ConnectionManager.closeConnection(conn);
   		}
		
		throw e;
	} //end of try-catch block
	
}
	
%>

</body>
</html>