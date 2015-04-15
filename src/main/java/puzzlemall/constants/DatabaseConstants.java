/**
 * 
 */
package puzzlemall.constants;

/**
 * This class contains constants used for database
 * related activities.
 *
 * The class contains various non-secure fields that are
 * used for the purpose of testing web application scanners,
 * and therefore, most of the fields in this class are NOT
 * suitable for implementing applications.
 *
 * @author Shay Chen
 * @since 1.0
 */
public final class DatabaseConstants {

    //*******************
    //* DERBY CONSTANTS *
    //*******************
	public static final String DERBY_DATABASE_NAME = 
		"db/puzzlemall_db";
	public static final String DERBY_CONNECTION_STRING = 
		"jdbc:derby:" + DERBY_DATABASE_NAME + ";";
	public static final String DERBY_DATABASE_DRIVER = 
		"org.apache.derby.jdbc.EmbeddedDriver";
	
    //*******************
    //* MYSQL CONSTANTS *
    //*******************
    /**
     * This constant is used as the global database driver string.
     * @since 1.0
     */
    public static final String DATABASE_DRIVER =
        "com.mysql.jdbc.Driver";
    /**
     * This constant is used as the global database connection string.
     * @since 1.0.2
     */
    public static final String DATABASE_NAME =
    	"puzzlemallDB";
        //"jdbc:mysql://localhost:3306/puzzlemallDB";
    /**
     * This constant is used to store the database account user name.
     * @since 1.0.2
     */
    public static final String USERNAME = "puzzlemall";
    /**
     * This constant is used to store the database account user name.
     * @since 1.0.2
     */
    public static final String PASSWORD = "puzzlemallPass2973";
    /**
     * This constant is used to store the connection pool name.
     * @since 1.0.2
     */
    public static final String CONNECTION_POOL_NAME = "PuzzlemallConnectionPool";

    //****************
    //* CONSTRUCTORS *
    //****************
    /**
     * The default constructor is disabled to prevent the creation
     * of class instances.
     * @throws Exception  Default constructor not supported
     * @since 1.0
     */
    private DatabaseConstants() throws Exception {
        throw new Exception("Default constructor not supported");
    } //end of constructor

} //end of class

