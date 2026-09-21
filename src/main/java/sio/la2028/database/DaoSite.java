package sio.la2028.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import sio.la2028.model.*;

public class DaoSite {

    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<Site> getLesSites(Connection cnx) {
        ArrayList<Site> lesSites = new ArrayList<>();
        try {
            String sql = "SELECT s.id AS s_id, s.nom AS s_nom, s.ville AS s_ville, " +
                    "p.id AS p_id, p.nom AS p_nom " +
                    "FROM site s INNER JOIN pays p ON s.pays_id = p.id";
            requeteSql = cnx.prepareStatement(sql);
            resultatRequete = requeteSql.executeQuery();

            while (resultatRequete.next()) {
                Site s = new Site();
                s.setId(resultatRequete.getInt("s_id"));
                s.setNom(resultatRequete.getString("s_nom"));
                s.setVille(resultatRequete.getString("s_ville"));

                Pays p = new Pays();
                p.setId(resultatRequete.getInt("p_id"));
                p.setNom(resultatRequete.getString("p_nom"));
                s.setPays(p);

                lesSites.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lesSites;
    }

    public static Site getSiteById(Connection cnx, int idSite) {
        Site s = null;
        try {
            String sql = "SELECT s.id AS s_id, s.nom AS s_nom, s.ville AS s_ville, " +
                    "p.id AS p_id, p.nom AS p_nom, " +
                    "e.id AS e_id, e.nom AS e_nom, " +
                    "sp.id AS sp_id, sp.nom AS sp_nom " +
                    "FROM site s " +
                    "INNER JOIN pays p ON s.pays_id = p.id " +
                    "LEFT JOIN site_epreuve se ON s.id = se.site_id " +
                    "LEFT JOIN epreuve e ON se.epreuve_id = e.id " +
                    "LEFT JOIN sport sp ON e.sport_id = sp.id " +
                    "WHERE s.id = ?";

            requeteSql = cnx.prepareStatement(sql);
            requeteSql.setInt(1, idSite);
            resultatRequete = requeteSql.executeQuery();

            while (resultatRequete.next()) {
                if (s == null) {
                    s = new Site();
                    s.setId(resultatRequete.getInt("s_id"));
                    s.setNom(resultatRequete.getString("s_nom"));
                    s.setVille(resultatRequete.getString("s_ville"));

                    Pays p = new Pays();
                    p.setId(resultatRequete.getInt("p_id"));
                    p.setNom(resultatRequete.getString("p_nom"));
                    s.setPays(p);
                }

                if (resultatRequete.getObject("e_id") != null) {
                    epreuve e = new epreuve();
                    e.setId(resultatRequete.getInt("e_id"));
                    e.setNom(resultatRequete.getString("e_nom"));

                    Sport sp = new Sport();
                    sp.setId(resultatRequete.getInt("sp_id"));
                    sp.setNom(resultatRequete.getString("sp_nom"));
                    e.setSport(sp);

                    s.getLesEpreuves().add(e);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return s;
    }
}