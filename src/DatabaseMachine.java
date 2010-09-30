
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
    private static final String databaseURL = "jdbc:sqlite:/Users/antti/Repot/javaEE/forum/kanta.db";

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

        connect();
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
}
/*
    public void printMessagesFromTopic(int topicID){
        out.println("tulostetaan viestit...");
        try{
            Statement stat = conn.createStatement();
            ResultSet rs = stat.executeQuery("select * from messages where topicid = "+topicID+";");

            try{
                while (rs.next()) {
                  out.println("viesti = " + rs.getString("message"));
                  out.println("userID = " + rs.getString("userid"));
            }
            }catch(Exception e){out.println("juttu failas!!");};
            rs.close();
            conn.close();
        } catch (Exception e){out.println("statementin luonti failas!!");};
    }


    }
}*/
