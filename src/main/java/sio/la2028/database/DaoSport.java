package sio.la2028.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import sio.la2028.model.*;

public class DaoSport {

    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<Sport> getLesSports(Connection cnx){

        ArrayList<Sport> lesSports = new ArrayList<Sport>();
        try{
            requeteSql = cnx.prepareStatement("select s.id as s_id, s.nom as s_nom" +
                    " from sport s");
            //System.out.println("REQ="+ requeteSql);
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
            System.out.println("La requête de getLesPompiers e généré une erreur");
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
            System.out.println("La requête de getLesPompiers e généré une erreur");
        }
        return s;
    }
}
