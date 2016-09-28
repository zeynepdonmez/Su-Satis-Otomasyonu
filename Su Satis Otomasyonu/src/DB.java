


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;


public class DB {
    
       // veritabanı bağlanısı için gerekli bilgiler.
    private String dbName = "susatis";
    private String dbUserName = "root";
    private String dbPass = "";
    
    // class for name
    // dahil ettiğimiz jar kütüphanesini hazır konuma getirir
    private String driver = "com.mysql.jdbc.Driver";
    
    // url = bağlantı için gerekli konum
    private String url = "jdbc:mysql://localhost/";
    
    Connection conn = null;
    Statement st = null;

    public DB() {
    }
 
    
    public DB(String dbName) {
        this.dbName = dbName;
    }
    
    
    // bağlan methodu
    public Statement baglan(){
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url+dbName, dbUserName, dbPass);
            st = conn.createStatement();
        } catch (Exception e) {
            System.err.println("Bağlantı Hatası : " + e);
        }
        return st;
    }
    
    
}
