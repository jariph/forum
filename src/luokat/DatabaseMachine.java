package luokat;


import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author 0700758
 */


public class DatabaseMachine {

    /*Käytetään singletonia, eli annetaan luoda vain yksi olio*/
    private static DatabaseMachine singleton;

    /*SQLite-Ajuri*/
    private static final String driver = "org.sqlite.JDBC";

    /*Tietokannan osoite ( Täytyy olla tarkkapolku esim: jdbc:sqlite:/Users/antti/Repot/javaEE/forum/kanta.db )*/
    private static final String databaseURL = "jdbc:sqlite:C:/foorum/forum/forum/kanta.sqlite";

    /*Yhtys ja statement*/
    private Connection conn;
    private Statement stat;

    /*Singletonin privaatti rakentaja*/
    private DatabaseMachine(){

        conn = null;
        stat = null;

        try{
            /*Rekiströidään ajuri*/
            Class.forName(driver);
        }
        catch(ClassNotFoundException cnf){
            System.out.println( "Ajuri failas! " + cnf ); }
}

    private void connect(){
        try{
            /*Luodaan yhteys*/
            conn = DriverManager.getConnection(databaseURL);
            stat = conn.createStatement();
        }
        catch(Exception e){
            System.out.println( "Ei saatu yhteyttä kantaan!"); }
    }

    private void disconnect(){
        try{
            conn.close();
        }
        catch(Exception e){
            System.out.println( "Ei saatu suljettua!"); }
    }

    /**databaseMachinen julkinen rakentaja.
     Jos olio on jo kertaalleen luotu, palautetaan sama olio.*/
    public static DatabaseMachine createDatabaseMachine(){
        if(singleton == null)
            singleton = new DatabaseMachine();
        return singleton;
    }

    public void printMessagesFromTopic(PrintWriter out, int topicID){
        out.println("tulostetaan viestit...");
        connect();
        try{
            ResultSet rs = stat.executeQuery("select * from messages where topicid = "+topicID+";");

            try{
                while (rs.next()) {
                  out.println("viesti = " + rs.getString("message"));
                  out.println("userID = " + rs.getString("userid"));
            }

            }catch(Exception e){out.println("juttu failas!!");};
            rs.close();
            conn.close();
        } catch (Exception e){out.println("statementin luonti failas!!"+e);};
    }

    /*Käyttäjän lisäys kantaan. TODO: SQL-injektioiden esto puuttuu vielä!!*/
    public void addUser(String username, String password){
        connect();
        try{
            String salt = "suola354Rxz";
            String hash = MD5.makeHash(password + salt);
            stat.executeQuery("INSERT INTO users (username, password) VALUES ('"+username+"','"+hash+"');");
        } catch (Exception e){};
        disconnect();
    }

    /*Käyttäjän lisäys kantaan. TODO: SQL-injektioiden esto puuttuu vielä!!*/
    public void addTopic(String userID, String topic, String message){
        connect();
        try{
            stat.executeQuery("INSERT INTO topics (userid, topic) VALUES ('"+userID+"','"+topic+"');");
        } catch (Exception e){};
        disconnect();
        connect();
        try{
            String lastTopicID = "(SELECT MAX(id) FROM topics)";
            stat.executeQuery("INSERT INTO messages (topicid, userid, message) VALUES ("+lastTopicID+",'"+userID+"','"+message+"');");
        } catch (Exception e){};
        disconnect();
    }

    /*Salasanan tarkistus. TODO: SQL-injektioiden esto puuttuu vielä!!*/
    public boolean checkPassword(String username, String password){
        boolean result = false;
        connect();
        try{
            String salt = "suola354Rxz";
            String hash = MD5.makeHash(password + salt);

            ResultSet rs = stat.executeQuery("select * from users where username = '"+username+"' AND password = '"+hash+"';");

            while (rs.next())
                result = true; //tunnus ja salis vastasivat toisiaan

            rs.close();

        } catch (Exception e){};
        disconnect();
        return result;
    }
}
