package sio.la2028.model;

import java.util.ArrayList;

public class Site {
    private int id;
    private String nom;
    private String ville;
    private Pays pays;
    private ArrayList<epreuve> lesEpreuves;

    public Site() {
        this.lesEpreuves = new ArrayList<epreuve>();
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getVille() { return ville; }
    public void setVille(String ville) { this.ville = ville; }
    public Pays getPays() { return pays; }
    public void setPays(Pays pays) { this.pays = pays; }
    public ArrayList<epreuve> getLesEpreuves() { return lesEpreuves; }
    public void setLesEpreuves(ArrayList<epreuve> lesEpreuves) { this.lesEpreuves = lesEpreuves; }
}