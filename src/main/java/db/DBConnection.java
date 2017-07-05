package db;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import beans.Literature;
import beans.Name;
import beans.list.LiteratureList;
import beans.user.LoginCredentials;
import beans.user.User;

import javax.xml.transform.Result;

public class DBConnection {
    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/library_system";

    //  Database credentials
    static final String USER = "root";
    static final String PASS = "root";

    public DBConnection(){

    }

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

    public User getCurrentUser(String username, String pass){
        ResultSet rs = null;
        Connection con = connect();
        CallableStatement stmt = null;
        try {
            stmt = con.prepareCall("{CALL get_user_information(?,?)}");
            stmt.setString(1, username);
            stmt.setString(2, pass);
            boolean hasResults = stmt.execute();
            rs = stmt.getResultSet();
            if(rs == null) {
                con.close();
                return null;
            }
            else{
                User user = new User();
                user.setId(Integer.toString(rs.getInt(1)));
                user.setEmail(rs.getString(8));
                user.setCredentials(new LoginCredentials(rs.getString(6),rs.getString(7)));
                user.setName(new Name(rs.getString(3), rs.getString(5), rs.getString(4)));
                user.setBirthday(rs.getDate(9));
                con.close();
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean userExist(String user,String pass){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL check_user_exist(?,?)}");
            stmt.setString(1, user);
            stmt.setString(2, pass);
            stmt.execute();
            con.close();
            return stmt.getBoolean("exist");

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public LiteratureList getAllLiterature(){
        ResultSet rs = null;
        Connection con = connect();
        CallableStatement stmt;
        LiteratureList list = null;
        try {
            stmt = con.prepareCall("{CALL get_all_literature()}");
            stmt.execute();
            boolean hasResults = stmt.execute();
            rs = stmt.getResultSet();
            if(rs == null)
                return null;
            else{
                while(rs.next()){
                    Literature lit = new Literature();
                    lit.setId(rs.getInt(1));
                    lit.setTitle(rs.getString(3));
                    lit.setDatePublished(rs.getDate(4));
                    lit.setPublisher(rs.getString(5));
                    lit.setDds(Integer.toString(rs.getInt(6)));
                    ResultSet rs2 = null;
                    stmt = con.prepareCall("{CALL get_all_authors_by_reservable(?)}");
                    stmt.setInt(1, (int) lit.getId());
                    hasResults = stmt.execute();
                    while (hasResults) {
                        rs2 = stmt.getResultSet();
                        hasResults = stmt.getMoreResults();
                    }
                    if(rs == null)
                        lit.addAuthor(new Name("N/A", "N/A", "N/A"));
                    else{
                        while(!rs.isAfterLast())
                            lit.addAuthor(new Name(rs.getString(1), rs.getString(3), rs.getString(2)));
                    }
                    list.add(lit);
                }
            }
            con.close();
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }

}
