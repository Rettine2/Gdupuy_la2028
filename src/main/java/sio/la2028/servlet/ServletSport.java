package sio.la2028.servlet;

import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import sio.la2028.database.*;
import sio.la2028.model.*;

public class ServletSport extends HttpServlet {

    Connection cnx;

    @Override
    public void init() {
        ServletContext servletContext = getServletContext();

        System.out.println("SERVLET CONTEXT=" + servletContext.getContextPath());
        cnx = (Connection) servletContext.getAttribute("connection");

        try {
            System.out.println("INIT SERVLET=" + cnx.getSchema());
        } catch (SQLException ex) {
            Logger.getLogger(ServletSport.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletSport</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletSport at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = request.getRequestURI();

        // Récup et affichage des sports[cite: 1]
        if (url.equals("/la2028/ServletSport/lister")) {
            ArrayList<Sport> lesSports = DaoSport.getLesSports(cnx);
            request.setAttribute("pLesSports", lesSports);
            getServletContext().getRequestDispatcher("/vues/sport/listerSports.jsp").forward(request, response);
        }

        if (url.equals("/la2028/ServletSport/consulter")) {
            int idSport = Integer.parseInt((String) request.getParameter("idSport"));
            Sport s = DaoSport.getSportsById(cnx, idSport);
            request.setAttribute("pSport", s);
            getServletContext().getRequestDispatcher("/vues/sport/consulterSports.jsp").forward(request, response);
        }

        // Affichage du formulaire d'ajout avec la liste des athlètes pour association optionnelle[cite: 1]
        if (url.equals("/la2028/ServletSport/ajouter")) {
            ArrayList<Athlete> lesAthletes = DaoAthlete.getLesAthletes(cnx);
            request.setAttribute("pLesAthletes", lesAthletes);
            this.getServletContext().getRequestDispatcher("/vues/sport/ajouterSports.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupération des paramètres du formulaire pour le sport
        String nomSport = request.getParameter("nomSport");
        String[] idsAthletes = request.getParameterValues("idsAthletes"); // Liste optionnelle des athlètes sélectionnés

        // Gestion optionnelle de l'image
        String nomImage = null;
        try {
            Part filePart = request.getPart("imageSport");
            if (filePart != null && filePart.getSize() > 0) {
                nomImage = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            }
        } catch (Exception e) {
            // Aucun fichier ou gestion multipart non requise si géré autrement
        }

        Sport sport = new Sport();
        sport.setNom(nomSport);
        // sport.setImage(nomImage); // Décommente si la méthode existe dans ton modèle Sport

        request.setAttribute("pSport", sport);

        // Validation simple et insertion en base de données
        if (nomSport != null && !nomSport.trim().isEmpty()) {
            DaoSport.addSport(cnx, sport);

            // Si tu gères l'association des athlètes dans ton DAO (optionnel) :
            // if (idsAthletes != null) {
            //     DaoSport.associerAthletes(cnx, sport.getId(), idsAthletes);
            // }

            // Redirection vers la liste des sports après un ajout réussi[cite: 1]
            ArrayList<Sport> lesSports = DaoSport.getLesSports(cnx);
            request.setAttribute("pLesSports", lesSports);
            this.getServletContext().getRequestDispatcher("/vues/sport/listerSports.jsp").forward(request, response);
        } else {
            // En cas d'erreur de saisie, on recharge le formulaire avec les athlètes
            request.setAttribute("erreur", "Le nom du sport est obligatoirement requis.");
            ArrayList<Athlete> lesAthletes = DaoAthlete.getLesAthletes(cnx);
            request.setAttribute("pLesAthletes", lesAthletes);
            this.getServletContext().getRequestDispatcher("/vues/sport/ajouterSports.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}