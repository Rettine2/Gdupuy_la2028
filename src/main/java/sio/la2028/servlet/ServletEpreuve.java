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

public class ServletEpreuve extends HttpServlet {

    Connection cnx ;

    @Override
    public void init()
    {
        ServletContext servletContext=getServletContext();
        cnx = (Connection)servletContext.getAttribute("connection");
        try {
            System.out.println("INIT SERVLET=" + cnx.getSchema());
        } catch (SQLException ex) {
            Logger.getLogger(ServletEpreuve.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // ...
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = request.getRequestURI();

        if(url.equals("/la2028/ServletEpreuve/lister")) {
            ArrayList<epreuve> lesEpreuves = DaoEpreuve.getLesEpreuves(cnx);
            request.setAttribute("pLesEpreuves", lesEpreuves);
            getServletContext().getRequestDispatcher("/vues/epreuve/listerEpreuves.jsp").forward(request, response);
        }
        else if(url.equals("/la2028/ServletEpreuve/consulter")) {
            int idEpreuve = Integer.parseInt(request.getParameter("idEpreuve"));
            epreuve e = DaoEpreuve.getEpreuveById(cnx, idEpreuve);
            request.setAttribute("pEpreuve", e);
            getServletContext().getRequestDispatcher("/vues/epreuve/consulterEpreuves.jsp").forward(request, response);
        }
        // --- NOUVELLE ROUTE GET ---
        else if(url.equals("/la2028/ServletEpreuve/ajouter")) {
            ArrayList<Sport> lesSports = DaoSport.getLesSports(cnx);
            ArrayList<Site> lesSites = DaoSite.getLesSites(cnx); // Nécessite que DaoSite soit fonctionnel

            request.setAttribute("pLesSports", lesSports);
            request.setAttribute("pLesSites", lesSites);
            getServletContext().getRequestDispatcher("/vues/epreuve/ajouterEpreuves.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = request.getRequestURI();

        if(url.equals("/la2028/ServletEpreuve/ajouter")) {
            String nomEpreuve = request.getParameter("nomEpreuve");
            int idSport = Integer.parseInt(request.getParameter("idSport"));
            String[] idsSites = request.getParameterValues("idsSites");

            epreuve e = new epreuve();
            e.setNom(nomEpreuve);

            Sport s = new Sport();
            s.setId(idSport);
            e.setSport(s);

            ArrayList<Site> sitesLies = new ArrayList<>();
            if (idsSites != null) {
                for (String idSiteStr : idsSites) {
                    Site site = new Site();
                    site.setId(Integer.parseInt(idSiteStr));
                    sitesLies.add(site);
                }
            }
            e.setLesSites(sitesLies);

            DaoEpreuve.addEpreuve(cnx, e);
            response.sendRedirect(request.getContextPath() + "/ServletEpreuve/lister");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}