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
            requeteSql = cnx.prepareStatement("select e.id as e_id, e.nom as e_nom, s.id as s_id, s.nom as s_nom" +
                    " from epreuve e inner join sport s" +
                    " on e.sport_id = s.id");
            resultatRequete = requeteSql.executeQuery();

            while (resultatRequete.next()){

                epreuve e = new epreuve();
                e.setId(resultatRequete.getInt("e_id"));
                e.setNom(resultatRequete.getString("e_nom"));

                Sport s = new Sport();
                s.setId(resultatRequete.getInt("s_id"));
                s.setNom(resultatRequete.getString("s_nom"));

                e.setSport(s);

                lesEpreuves.add(e);
            }

        }
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getLesEpreuves a généré une erreur");
        }
        return lesEpreuves;
    }

    public static epreuve getEpreuveById(Connection cnx, int idEpreuve) {
        epreuve e = null;

        try {
            // Requête SQL avec des jointures pour récupérer l'épreuve, le sport et l'athlète
            String sql = "SELECT e.id AS e_id, e.nom AS e_nom, " +
                    "s.id AS s_id, s.nom AS s_nom, " +
                    "a.id AS a_id, a.prenom AS a_prenom, a.nom AS a_nom " +
                    "FROM epreuve e " +
                    "INNER JOIN sport s ON e.sport_id = s.id " +
                    "INNER JOIN athlete a ON e.athlete_id = a.id " +
                    "WHERE e.id = ?";

            requeteSql = cnx.prepareStatement(sql);
            requeteSql.setInt(1, idEpreuve); // On remplace le '?' par l'ID de l'épreuve

            resultatRequete = requeteSql.executeQuery();

            // Si on trouve un résultat (if au lieu de while car un seul résultat par ID)
            if (resultatRequete.next()) {
                e = new epreuve();
                e.setId(resultatRequete.getInt("e_id"));
                e.setNom(resultatRequete.getString("e_nom"));

                // Hydratation de l'objet Sport
                Sport s = new Sport();
                s.setId(resultatRequete.getInt("s_id"));
                s.setNom(resultatRequete.getString("s_nom"));
                e.setSport(s);

                // Hydratation de l'objet Athlete
                Athlete a = new Athlete();
                a.setId(resultatRequete.getInt("a_id"));
                a.setPrenom(resultatRequete.getString("a_prenom"));
                a.setNom(resultatRequete.getString("a_nom"));
                e.setAthlete(a);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("La requête getEpreuveById a généré une erreur");
        }

        return e; // Retourne l'épreuve complète, ou null si l'ID n'existe pas
    }
}