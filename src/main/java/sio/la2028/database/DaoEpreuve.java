package sio.la2028.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import sio.la2028.model.*;

/**
 *
 * @author zakina
 */
public class DaoEpreuve {

    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<epreuve> getLesEpreuves(Connection cnx){

        ArrayList<epreuve> lesEpreuves = new ArrayList<epreuve>();
        try{
            requeteSql = cnx.prepareStatement("select e.id as e_id, e.nom as e_nom, s.id as s_id, s.nom as s_nom, a.id as a_id, a.nom as a_nom, a.prenom as a_prenom " +
                    " from epreuve e inner join sport s" +
                    " on e.sport_id = s.id" +
                    " left join athlete a" +
                    " on e.athlete_id = a.id");
            //System.out.println("REQ="+ requeteSql);
            resultatRequete = requeteSql.executeQuery();

            while (resultatRequete.next()){

                epreuve e = new epreuve();
                e.setId(resultatRequete.getInt("e_id"));
                e.setNom(resultatRequete.getString("e_nom"));

                e.setLesEpreuves(e.getLesEpreuves());

                Sport s = new Sport();
                s.setId(resultatRequete.getInt("s_id"));
                s.setNom(resultatRequete.getString("s_nom"));

                e.setSport(s);

                Athlete a = new Athlete();
                a.setId(resultatRequete.getInt("a_id"));
                a.setNom(resultatRequete.getString("a_nom"));
                a.setPrenom(resultatRequete.getString("a_prenom"));

                e.setAthlete(a);



            }

        }
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getLesPompiers e généré une erreur");
        }
        return lesEpreuves;
    }
}