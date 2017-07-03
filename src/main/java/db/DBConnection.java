package db;
import java.sql.*;

public class DBConnection {
    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/library_system";

    //  Database credentials
    static final String USER = "root";
    static final String PASS = "root";

    public Connection connect() {
        Connection con;
        String driver = "com.mysql.jdbc.Driver";
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(DB_URL, USER, PASS);
            if (con == null) {
                System.out.println("Connection cannot be established");
            }
            return con;
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

}
