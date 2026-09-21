package sio.la2028.model;

import java.util.ArrayList;

public class epreuve {
    private int id;
    private String nom;
    private Sport sport;

    private ArrayList<Athlete> lesAthletes;
    private ArrayList<Site> lesSites;

    public epreuve() {
        this.lesAthletes = new ArrayList<Athlete>();
        this.lesSites = new ArrayList<Site>();
    }

    public epreuve(int id, String nom) {
        this.id = id;
        this.nom = nom;
        this.lesAthletes = new ArrayList<Athlete>();
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

    public Sport getSport() {
        return sport;
    }

    public void setSport(Sport sport) {
        this.sport = sport;
    }

    public ArrayList<Athlete> getLesAthletes() {
        return lesAthletes;
    }

    public void setLesAthletes(ArrayList<Athlete> lesAthletes) {
        this.lesAthletes = lesAthletes;
    }

    public ArrayList<Site> getLesSites() {
        return lesSites;
    }

    public void setLesSites(ArrayList<Site> lesSites) {
        this.lesSites = lesSites;
    }
}