package sio.la2028.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import sio.la2028.model.*;

public class DaoSport {

    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<Sport> getLesSports(Connection cnx){
        ArrayList<Sport> lesSports = new ArrayList<Sport>();
        try{
            requeteSql = cnx.prepareStatement("select s.id as s_id, s.nom as s_nom from sport s");
            resultatRequete = requeteSql.executeQuery();

            while (resultatRequete.next()){
                Sport s = new Sport();
                s.setId(resultatRequete.getInt("s_id"));
                s.setNom(resultatRequete.getString("s_nom"));
                lesSports.add(s);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getLesSports a généré une erreur");
        }
        return lesSports;
    }

    public static Sport getSportsById(Connection cnx, int idSport){
        ArrayList<Athlete> lesAthletes = new ArrayList<Athlete>();
        Sport s = new Sport();
        try{
            requeteSql = cnx.prepareStatement("select a.nom as a_nom, a.prenom as a_prenom,  s.id as s_id, s.nom as s_nom" +
                    " from athlete a inner join sport s " +
                    " on a.sport_id = s.id " +
                    " where s.id = ? ");
            requeteSql.setInt(1, idSport);
            resultatRequete = requeteSql.executeQuery();

            while (resultatRequete.next()){
                s.setId(resultatRequete.getInt("s_id"));
                s.setNom(resultatRequete.getString("s_nom"));

                Athlete a = new Athlete();
                a.setNom(resultatRequete.getString("a_nom"));
                a.setPrenom(resultatRequete.getString("a_prenom"));

                lesAthletes.add(a);
            }
            s.setLesAthletes(lesAthletes);
        }
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getSportsById a généré une erreur");
        }
        return s;
    }


    public static int addSport(Connection cnx, Sport sport) {
        int idGenere = -1;
        try {
            requeteSql = cnx.prepareStatement("INSERT INTO sport (nom) VALUES (?)", Statement.RETURN_GENERATED_KEYS);
            requeteSql.setString(1, sport.getNom());
            requeteSql.executeUpdate();

            resultatRequete = requeteSql.getGeneratedKeys();
            if (resultatRequete.next()) {
                idGenere = resultatRequete.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de addSport a généré une erreur");
        }
        return idGenere;
    }


    public static void updateAthleteSport(Connection cnx, int idAthlete, int idSport) {
        try {
            requeteSql = cnx.prepareStatement("UPDATE athlete SET sport_id = ? WHERE id = ?");
            requeteSql.setInt(1, idSport);
            requeteSql.setInt(2, idAthlete);
            requeteSql.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("La requête de updateAthleteSport a généré une erreur");
        }
    }
}