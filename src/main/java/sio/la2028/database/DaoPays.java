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

import sio.la2028.model.Athlete;
import sio.la2028.model.Pays;
import sio.la2028.model.Sport;

/**
 *
 * @author zakina
 */
public class DaoPays {
    
    Connection cnx;
    static PreparedStatement requeteSql = null;
    static ResultSet resultatRequete = null;
    
    public static ArrayList<Pays> getLesPays(Connection cnx){
        
         ArrayList<Pays> lesPays = new ArrayList<Pays>();
        try{
            requeteSql = cnx.prepareStatement("select * from pays");
            //System.out.println("REQ="+ requeteSql);
            resultatRequete = requeteSql.executeQuery();
            
            while (resultatRequete.next()){
                
                Pays p = new Pays();
                p.setId(resultatRequete.getInt("id"));
                p.setNom(resultatRequete.getString("nom"));
                p.setCode(resultatRequete.getString("code"));
                
                lesPays.add(p);
            }
           
        }
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getLespays à généré une erreur");
        }
        return lesPays;
        
    }

    public static Pays getPaysById(Connection cnx, int idPays){
        ArrayList<Athlete> lesAthletes = new ArrayList<Athlete>();
        Pays p = new Pays();
        try{
            requeteSql = cnx.prepareStatement("select a.nom as a_nom, a.prenom as a_prenom,  p.id as p_id, p.nom as p_nom, p.code as p_code" +
                    " from athlete a inner join pays p " +
                    " on a.pays_id = p.id " +
                    " where p.id = ? ");
            requeteSql.setInt(1, idPays);
            resultatRequete = requeteSql.executeQuery();

            while (resultatRequete.next()){

                p.setId(resultatRequete.getInt("p_id"));
                p.setCode(resultatRequete.getString("p_code"));
                p.setNom(resultatRequete.getString("p_nom"));

                Athlete a = new Athlete();
                a.setNom(resultatRequete.getString("a_nom"));
                a.setPrenom(resultatRequete.getString("a_prenom"));

                lesAthletes.add(a);
            }
            p.setLesAthletes(lesAthletes);
        }
        catch (SQLException e){
            e.printStackTrace();
            System.out.println("La requête de getLesPompiers e généré une erreur");
        }
        return p;
    }
    
}
