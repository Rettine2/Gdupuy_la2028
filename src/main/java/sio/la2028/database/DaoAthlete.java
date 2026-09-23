/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sio.la2028.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import sio.la2028.model.*;
import java.sql.Date;

/**
 *
 * @author zakina
 */
public class DaoAthlete {

    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;

    public static ArrayList<Athlete> getLesAthletes(Connection cnx){

        ArrayList<Athlete> lesAthletes = new ArrayList<Athlete>();
        try{
            // Ajout de p.code dans la requête SQL[cite: 14]
            requeteSql = cnx.prepareStatement("select a.id as a_id, a.nom as a_nom, a.prenom as a_prenom, a.date_naissance as a_dateNaiss,  p.id as p_id, p.nom as p_nom, p.code as p_code, s.id as s_id, s.nom as s_nom " +
                    " from athlete a inner join pays p" +
                    " on a.pays_id = p.id" +
                    " left join sport s" +
                    " on a.sport_id = s.id");
            resultatRequete = requeteSql.executeQuery();

            while (resultatRequete.next()){

                Athlete a = new Athlete();
                a.setId(resultatRequete.getInt("a_id"));
                a.setNom(resultatRequete.getString("a_nom"));
                a.setPrenom(resultatRequete.getString("a_prenom"));
                a.setDateNaissance(resultatRequete.getDate("a_dateNaiss").toLocalDate());

                Pays p = new Pays();
                p.setId(resultatRequete.getInt("p_id"));
                p.setNom(resultatRequete.getString("p_nom"));
                p.setCode(resultatRequete.getString("p_code")); // Hydratation du code pays[cite: 14]

                a.setPays(p);

                Sport s = new Sport();
                s.setId(resultatRequete.getInt("s_id"));
                s.setNom(resultatRequete.getString("s_nom"));

                a.setSport(s);

                lesAthletes.add(a);
            }

        }
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getLesPompiers e généré une erreur");
        }
        return lesAthletes;
    }

    public static Athlete getAthleteById(Connection cnx, int idAthlete){

        Athlete a = new Athlete();
        try{
            // Ajout de p.code dans la requête SQL[cite: 14]
            requeteSql = cnx.prepareStatement("select a.id as a_id, a.nom as a_nom, a.prenom as a_prenom, a.date_naissance as a_dateNaiss,  p.id as p_id, p.nom as p_nom, p.code as p_code, s.id as s_id, s.nom as s_nom " +
                    " from athlete a inner join pays p " +
                    " on a.pays_id = p.id " +
                    " left join sport s" +
                    " on a.sport_id = s.id" +
                    " where a.id = ? ");
            requeteSql.setInt(1, idAthlete);
            resultatRequete = requeteSql.executeQuery();

            if (resultatRequete.next()){

                a.setId(resultatRequete.getInt("a_id"));
                a.setNom(resultatRequete.getString("a_nom"));
                a.setPrenom(resultatRequete.getString("a_prenom"));
                a.setDateNaissance(resultatRequete.getDate("a_dateNaiss").toLocalDate());

                Pays p = new Pays();
                p.setId(resultatRequete.getInt("p_id"));
                p.setNom(resultatRequete.getString("p_nom"));
                p.setCode(resultatRequete.getString("p_code")); // Hydratation du code pays[cite: 14]

                a.setPays(p);

                Sport s = new Sport();
                s.setId(resultatRequete.getInt("s_id"));
                s.setNom(resultatRequete.getString("s_nom"));

                a.setSport(s);

            }

        }
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getLesPompiers e généré une erreur");
        }
        return a;
    }

    public static Athlete addAthlete(Connection connection, Athlete ath){
        int idGenere = -1;
        try
        {
            requeteSql=connection.prepareStatement("INSERT INTO athlete (nom, pays_id)\n" +
                    "VALUES (?,?)", requeteSql.RETURN_GENERATED_KEYS );
            requeteSql.setString(1, ath.getNom());
            requeteSql.setInt(2, ath.getPays().getId());

            requeteSql.executeUpdate();

            resultatRequete = requeteSql.getGeneratedKeys();
            while ( resultatRequete.next() ) {
                idGenere = resultatRequete.getInt( 1 );
                ath.setId(idGenere);

                ath = DaoAthlete.getAthleteById(connection, ath.getId());
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return ath ;
    }
}