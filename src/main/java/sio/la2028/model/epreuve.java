package sio.la2028.model;

import java.util.ArrayList;

public class epreuve {
    private int id;
    private String nom ;
    private ArrayList<epreuve> lesEpreuves ;
    private Sport sport;

    public epreuve() {
    }

    public Sport getSport() {
        return sport;
    }

    public void setSport(Sport sport) {
        this.sport = sport;
    }

    public ArrayList<epreuve> getLesEpreuves() {
        return lesEpreuves;
    }

    public void setLesEpreuves(ArrayList<epreuve> lesEpreuves) {
        this.lesEpreuves = lesEpreuves;
    }

    public epreuve(int id, String nom) {
        this.id = id;
        this.nom = nom;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

}
