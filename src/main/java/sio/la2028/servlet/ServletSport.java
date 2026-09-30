package sio.la2028.servlet;

import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

        if (url.equals("/la2028/ServletSport/ajouter")) {
            ArrayList<Athlete> lesAthletes = DaoAthlete.getLesAthletes(cnx);
            request.setAttribute("pLesAthletes", lesAthletes);
            this.getServletContext().getRequestDispatcher("/vues/sport/ajouterSports.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nomSport = request.getParameter("nomSport");

        String[] idsAthletes = request.getParameterValues("idsAthletes");

        Sport sport = new Sport();
        sport.setNom(nomSport);

        request.setAttribute("pSport", sport);

        if (nomSport != null && !nomSport.trim().isEmpty()) {

            int idSportGenere = DaoSport.addSport(cnx, sport);


            if (idSportGenere != -1 && idsAthletes != null) {
                for (String idAthleteStr : idsAthletes) {
                    try {
                        int idAthlete = Integer.parseInt(idAthleteStr);
                        DaoSport.updateAthleteSport(cnx, idAthlete, idSportGenere);
                    } catch (NumberFormatException e) {
                        System.out.println("Erreur de parsing de l'ID athlète : " + idAthleteStr);
                    }
                }
            }

            ArrayList<Sport> lesSports = DaoSport.getLesSports(cnx);
            request.setAttribute("pLesSports", lesSports);
            this.getServletContext().getRequestDispatcher("/vues/sport/listerSports.jsp").forward(request, response);
        } else {
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