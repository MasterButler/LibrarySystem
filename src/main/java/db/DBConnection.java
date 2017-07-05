package db;
import java.sql.*;
import java.util.ArrayList;

import beans.Literature;
import beans.Name;
import beans.list.LiteratureList;
import beans.user.LoginCredentials;
import beans.user.User;

public class DBConnection {
    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/library_system";

    //  Database credentials
    static final String USER = "root";
    static final String PASS = "password";

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

    //U
    //S
    //E
    //R
    //S
    public User getCurrentUser(String username, String pass){
        ResultSet rs;
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL get_user_information(?,?)}");
            stmt.setString(1, username);
            stmt.setString(2, pass);
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

    public ArrayList<String> userSecretAnswers(String user, String pass){
        ResultSet rs;
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL get_user_secret_answers(?,?)}");
            stmt.setString(1, user);
            stmt.setString(2, pass);
            rs = stmt.getResultSet();
            if(rs == null) {
                con.close();
                return null;
            }
            else{
                ArrayList<String> arr = new ArrayList<String>();
                arr.add(rs.getString(1));
                arr.add(rs.getString(2));
                return arr;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public void addUser(int type, String first, String last, String middle, String user, String pass, String email, String date){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL add_user(?,?,?,?,?,?,?,?)}");
            stmt.setInt(1,type);
            stmt.setString(2,first);
            stmt.setString(3,last);
            stmt.setString(4,middle);
            stmt.setString(5,user);
            stmt.setString(6,pass);
            stmt.setString(7,email);
            stmt.setString(8,date);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addUserWithID(int id, int type, String first, String last, String middle, String user, String pass, String email, String date){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL add_user_with_id(?,?,?,?,?,?,?,?,?)}");
            stmt.setInt(1,id);
            stmt.setInt(2,type);
            stmt.setString(3,first);
            stmt.setString(4,last);
            stmt.setString(5,middle);
            stmt.setString(6,user);
            stmt.setString(7,pass);
            stmt.setString(8,email);
            stmt.setString(9,date);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateUser(String oldUser, String oldPass, int type, String first, String last, String middle, String user, String pass, String email, String date){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL update_user(?,?,?,?,?,?,?,?,?,?)}");
            stmt.setString(1, oldUser);
            stmt.setString(2, oldPass);
            stmt.setInt(3,type);
            stmt.setString(4,first);
            stmt.setString(5,last);
            stmt.setString(6,middle);
            stmt.setString(7,user);
            stmt.setString(8,pass);
            stmt.setString(9,email);
            stmt.setString(10,date);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(String user, String pass){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL delete_user(?,?,?,?,?,?,?,?,?,?)}");
            stmt.setString(1, user);
            stmt.setString(2, pass);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //L
    //I
    //T
    //E
    //R
    //A
    //T
    //U
    //R
    //E
    public LiteratureList getAllLiterature(){
        ResultSet rs;
        Connection con = connect();
        CallableStatement stmt;
        LiteratureList list = null;
        try {
            stmt = con.prepareCall("{CALL get_all_literature()}");
            stmt.execute();
            rs = stmt.getResultSet();
            list = createLiteratureList(list, rs, con);
            con.close();
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }

    public LiteratureList getLiteratureByTitle(String title){
        ResultSet rs;
        Connection con = connect();
        CallableStatement stmt;
        LiteratureList list = null;
        try {
            stmt = con.prepareCall("{CALL get_all_literatures_by_title()}");
            stmt.setString(1, title);
            stmt.execute();
            rs = stmt.getResultSet();
            list = createLiteratureList(list, rs, con);
            con.close();
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public LiteratureList getLiteratureByPublisher(String pub){
        ResultSet rs;
        Connection con = connect();
        CallableStatement stmt;
        LiteratureList list = null;
        try {
            stmt = con.prepareCall("{CALL get_all_literatures_by_publisher()}");
            stmt.setString(1, pub);
            stmt.execute();
            rs = stmt.getResultSet();
            list = createLiteratureList(list, rs, con);
            con.close();
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public void updateLiterature(int id, int type, String title, String date, String publisher, int dds){//date format YYYY-MM-DD
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL update_literature(?,?,?,?,?,?)}");
            stmt.setInt(1,id);
            stmt.setInt(2,type);
            stmt.setString(3,title);
            stmt.setString(4,date);
            stmt.setString(5,publisher);
            stmt.setInt(6,dds);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void createLiteratureWithId(int id, int type, String title, String date, String publisher, int dds){//date format YYYY-MM-DD
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL create_literature_with_id(?,?,?,?,?,?)}");
            stmt.setInt(1,id);
            stmt.setInt(2,type);
            stmt.setString(3,title);
            stmt.setString(4,date);
            stmt.setString(5,publisher);
            stmt.setInt(6,dds);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void createLiterature(int type, String title, String date, String publisher, int dds){//date format YYYY-MM-DD
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL add_literature(?,?,?,?,?)}");
            stmt.setInt(1,type);
            stmt.setString(2,title);
            stmt.setString(3,date);
            stmt.setString(4,publisher);
            stmt.setInt(5,dds);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    public void deleteLiterature(int id){//date format YYYY-MM-DD
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL delete_literature(?)}");
            stmt.setInt(1,id);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public LiteratureList getLiteratureByAuthor(String last, String first){
        ResultSet rs;
        Connection con = connect();
        CallableStatement stmt;
        LiteratureList list = null;
        try {
            stmt = con.prepareCall("{CALL get_all_literatures_by_author()}");
            stmt.setString(1, last);
            stmt.setString(2, first);
            stmt.execute();
            rs = stmt.getResultSet();
            list = createLiteratureList(list, rs, con);
            con.close();
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public LiteratureList createLiteratureList(LiteratureList list, ResultSet rs, Connection con ) throws SQLException {
        CallableStatement stmt;
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
                ResultSet rs2;
                stmt = con.prepareCall("{CALL get_all_authors_by_reservable(?)}");
                stmt.setInt(1, (int) lit.getId());
                rs2 = stmt.getResultSet();
                if(rs2 == null)
                    lit.addAuthor(new Name("N/A", "N/A", "N/A"));
                else{
                    while(rs2.next())
                        lit.addAuthor(new Name(rs2.getString(1), rs2.getString(3), rs2.getString(2)));
                }
                list.add(lit);
            }
        }
        return list;
    }

    //A
    //U
    //T
    //H
    //O
    //R
    public void addAuthor(String last, String first, String middle){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL add_author(?,?,?)}");
            stmt.setString(1,last);
            stmt.setString(2,first);
            stmt.setString(3,middle);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addAuthorWithID(int id, String last, String first, String middle){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL add_author(?,?,?,?)}");
            stmt.setInt(1,id);
            stmt.setString(2,last);
            stmt.setString(3,first);
            stmt.setString(4,middle);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAuthor(int id){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL delete_author(?)}");
            stmt.setInt(1,id);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAuthor(int id, String last, String first, String middle){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL update_author(?,?,?,?)}");
            stmt.setInt(1,id);
            stmt.setString(2,last);
            stmt.setString(3,first);
            stmt.setString(4,middle);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //T
    //A
    //G
    //S

    public void addTag(int lit_id, int auth_id){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL add_tag(?,?)}");
            stmt.setInt(1,lit_id);
            stmt.setInt(2,auth_id);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addTagWithID(int id, int lit_id, int auth_id){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL add_tag(?,?,?)}");
            stmt.setInt(1,id);
            stmt.setInt(2,lit_id);
            stmt.setInt(3,auth_id);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteTag(int id){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL delete_tag(?)}");
            stmt.setInt(1,id);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateTag(int id, int lit_id, int auth_id){
        Connection con = connect();
        CallableStatement stmt;
        try {
            stmt = con.prepareCall("{CALL update_tag(?,?,?)}");
            stmt.setInt(1,id);
            stmt.setInt(2,lit_id);
            stmt.setInt(3,auth_id);
            stmt.executeUpdate();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
