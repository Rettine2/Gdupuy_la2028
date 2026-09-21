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
            String sql = "SELECT e.id AS e_id, e.nom AS e_nom, " +
                    "s.id AS s_id, s.nom AS s_nom, " +
                    "a.id AS a_id, a.prenom AS a_prenom, a.nom AS a_nom, a.date_naissance AS a_date_naissance, " +
                    "p.id AS p_id, p.Code AS p_code, p.nom AS p_nom, " +
                    "sa.id AS sa_id, sa.nom AS sa_nom " +
                    "FROM epreuve e " +
                    "INNER JOIN sport s ON e.sport_id = s.id " +
                    "LEFT JOIN epreuve_athlete ea ON e.id = ea.epreuve_id " +
                    "LEFT JOIN athlete a ON ea.athlete_id = a.id " +
                    "LEFT JOIN pays p ON a.pays_id = p.id " +
                    "LEFT JOIN sport sa ON a.sport_id = sa.id " +
                    "WHERE e.id = ?";

            requeteSql = cnx.prepareStatement(sql);
            requeteSql.setInt(1, idEpreuve);

            resultatRequete = requeteSql.executeQuery();

            while (resultatRequete.next()) {

                if (e == null) {
                    e = new epreuve();
                    e.setId(resultatRequete.getInt("e_id"));
                    e.setNom(resultatRequete.getString("e_nom"));

                    Sport s = new Sport();
                    s.setId(resultatRequete.getInt("s_id"));
                    s.setNom(resultatRequete.getString("s_nom"));
                    e.setSport(s);
                }

                if (resultatRequete.getObject("a_id") != null) {
                    Athlete a = new Athlete();
                    a.setId(resultatRequete.getInt("a_id"));
                    a.setPrenom(resultatRequete.getString("a_prenom"));
                    a.setNom(resultatRequete.getString("a_nom"));

                    if (resultatRequete.getDate("a_date_naissance") != null) {
                        a.setDateNaissance(resultatRequete.getDate("a_date_naissance").toLocalDate());
                    }

                    Pays p = new Pays();
                    p.setId(resultatRequete.getInt("p_id"));
                    p.setCode(resultatRequete.getString("p_code"));
                    p.setNom(resultatRequete.getString("p_nom"));
                    a.setPays(p);

                    Sport sa = new Sport();
                    sa.setId(resultatRequete.getInt("sa_id"));
                    sa.setNom(resultatRequete.getString("sa_nom"));
                    a.setSport(sa);

                    e.getLesAthletes().add(a);
                }
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            System.out.println("La requête getEpreuveById a généré une erreur");
        }

        return e;
    }
}