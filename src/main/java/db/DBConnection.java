package db;
import beans.Name;
import beans.user.User;
import beans.user.UserCredentials;

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

    public User getCurrentUser(String username, String pass) throws SQLException {
        ResultSet rs = null;
        Connection con = connect();
        CallableStatement stmt = con.prepareCall("{CALL get_user_information(?,?)}");
        stmt.setString(username, pass);
        boolean hasResults = stmt.execute();
        while (hasResults) {
            rs = stmt.getResultSet();
            hasResults = stmt.getMoreResults();
        }
        if(rs == null)
            return null;
        else{
            User user = new User();
            user.setId(Integer.toString(rs.getInt(1)));
            user.setCredentials(new UserCredentials(rs.getString(6),rs.getString(7),rs.getString(8)));
            user.setName(new Name(rs.getString(3), rs.getString(5), rs.getString(4)));
            user.setBirthday(rs.getDate(9));
            return user;
        }
    }

    public boolean userExist(String user,String pass){
        ResultSet rs = null;
        Connection con = connect();
        CallableStatement stmt = null;
        try {
            stmt = con.prepareCall("{CALL check_user_exist(?,?)}");
            stmt.setString(user, pass);
            stmt.execute();
            return stmt.getBoolean("exist");
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
