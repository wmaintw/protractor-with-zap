/**
 * 
 */
package puzzlemall.logic;

import java.sql.*;
import puzzlemall.database.ConnectionManager;

/**
 * @author Shay Chen
 * @since 1.0
 */
public final class DataAccessMethods {

	/**
	 * Checks the availability of a username.
	 * @return Returns true if the user name is not used, and false if it is.
	 * @since 1.0
	 */
	public static boolean isUsernameAvailable(String username){
		
		Connection conn = null;
		boolean retval = false;
		
		try {
			conn = ConnectionManager.getConnection();
			String SqlString = 
		        "SELECT username " +
		        "FROM users " +
		        "WHERE username = ?";

			Statement vulnerableStatement = conn.createStatement();
			ResultSet rs = vulnerableStatement.executeQuery(String.format("SELECT username FROM users WHERE username = '%s'", username));


//			PreparedStatement pstmt = conn.prepareStatement(SqlString);
//				pstmt.setString(1, username);
//
//				ResultSet rs = pstmt.executeQuery();
//
		 		if(rs.next()) {
		 			retval = false;
		 	    } else {
		 	    	retval = true;
		 	 	}

		 		if(conn != null) {
			    	ConnectionManager.closeConnection(conn);
			    }
		 		return retval;
		} catch (Exception e) {
			if(conn != null) {
		    	ConnectionManager.closeConnection(conn);
		    }
	 		return retval;
		}
	} //end of method
	
	
	/**
	 * Checks if the password matches the user.
	 * @return Returns true if the user-password match, and false if they don't.
	 * @since 1.0
	 */
	public static boolean isPasswordValid(String username, String password) {
		
		Connection conn = null;
		boolean retval = false;
		
		try {
			conn = ConnectionManager.getConnection();
			String SqlString = 
		        "SELECT * " +
		        "FROM users " +
		        "WHERE username = ? AND password = ?";
			
				PreparedStatement pstmt = conn.prepareStatement(SqlString);
				pstmt.setString(1, username);
				pstmt.setString(2, password);
				
				ResultSet rs = pstmt.executeQuery();
		 		
		 		if(rs.next()) {
		 			retval = true;
		 	    } else {
		 	    	retval = false;
		 	 	}
			
		 		if(conn != null) {
			    	ConnectionManager.closeConnection(conn);
			    }
		 		return retval;
		} catch (Exception e) {
			if(conn != null) {
		    	ConnectionManager.closeConnection(conn);
		    }
	 		return retval;
		}
	}
	
	
	/**
	 * Checks if the password recovery answer matches the user.
	 * @return Returns true if the user-answer match, and false if they don't.
	 * @since 1.0
	 */
	public static boolean isAnswerValid(String username, String recoveryAnswer) {
		
		Connection conn = null;
		boolean retval = false;
		
		try {
			conn = ConnectionManager.getConnection();
			String SqlString = 
		        "SELECT * " +
		        "FROM users " +
		        "WHERE username = ? AND recoveryAnswer = ?";
			
				PreparedStatement pstmt = conn.prepareStatement(SqlString);
				pstmt.setString(1, username);
				pstmt.setString(2, recoveryAnswer);
				
				ResultSet rs = pstmt.executeQuery();
		 		
		 		if(rs.next()) {
		 			retval = true;
		 	    } else {
		 	    	retval = false;
		 	 	}
			
		 		if(conn != null) {
			    	ConnectionManager.closeConnection(conn);
			    }
		 		return retval;
		} catch (Exception e) {
			if(conn != null) {
		    	ConnectionManager.closeConnection(conn);
		    }
	 		return retval;
		}
	}
	
	
	/**
	 * Returns the role of a given username.
	 * @return Returns the role string, or null for invalid users.
	 * @since 1.0
	 */
	public static String getUserRole(String username){
		
		Connection conn = null;
		String userrole = null;
		
		try {
			conn = ConnectionManager.getConnection();
			String SqlString = 
		        "SELECT role " +
		        "FROM users " +
		        "WHERE username = ?";
			
				PreparedStatement pstmt = conn.prepareStatement(SqlString);
				pstmt.setString(1, username);
				
				ResultSet rs = pstmt.executeQuery();
		 		
		 		if(rs.next()) {
		 			userrole = rs.getString(1);
		 	    } else {
		 	    	//invalid user
		 	    	userrole = null;
		 	 	}
			
		 		if(conn != null) {
			    	ConnectionManager.closeConnection(conn);
			    }
		 		return userrole;
		} catch (Exception e) {
			if(conn != null) {
		    	ConnectionManager.closeConnection(conn);
		    }
	 		return userrole;
		}
	} //end of method
	
	
	/**
	 * Returns the recovery question of a given username.
	 * @return Returns the question string, or null for invalid users.
	 * @since 1.0
	 */
	public static String getRecoveryQuestion(String username){
		
		Connection conn = null;
		String recoveryQuestion = null;
		
		try {
			conn = ConnectionManager.getConnection();
			String SqlString = 
		        "SELECT recoveryQuestion " +
		        "FROM users " +
		        "WHERE username = ?";
			
				PreparedStatement pstmt = conn.prepareStatement(SqlString);
				pstmt.setString(1, username);
				
				ResultSet rs = pstmt.executeQuery();
		 		
		 		if(rs.next()) {
		 			recoveryQuestion = rs.getString(1);
		 	    } else {
		 	    	//invalid user
		 	    	recoveryQuestion = null;
		 	 	}
			
		 		if(conn != null) {
			    	ConnectionManager.closeConnection(conn);
			    }
		 		return recoveryQuestion;
		} catch (Exception e) {
			if(conn != null) {
		    	ConnectionManager.closeConnection(conn);
		    }
	 		return recoveryQuestion;
		}
	} //end of method
	
} //end of class
