package sio.la2028.servlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import sio.la2028.database.*;
import sio.la2028.model.*;

public class ServletSite extends HttpServlet {

    Connection cnx;

    @Override
    public void init() {
        ServletContext servletContext = getServletContext();
        cnx = (Connection) servletContext.getAttribute("connection");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = request.getRequestURI();

        if (url.equals("/la2028/ServletSite/lister")) {
            ArrayList<Site> lesSites = DaoSite.getLesSites(cnx);
            request.setAttribute("pLesSites", lesSites);
            getServletContext().getRequestDispatcher("/vues/site/listerSites.jsp").forward(request, response);
        }
        else if (url.equals("/la2028/ServletSite/consulter")) {
            int idSite = Integer.parseInt(request.getParameter("idSite"));
            Site s = DaoSite.getSiteById(cnx, idSite);
            request.setAttribute("pSite", s);
            getServletContext().getRequestDispatcher("/vues/site/consulterSite.jsp").forward(request, response);
        }
        else if (url.equals("/la2028/ServletSite/ajouter")) {
            ArrayList<Pays> lesPays = DaoPays.getLesPays(cnx);
            ArrayList<epreuve> lesEpreuves = DaoEpreuve.getLesEpreuves(cnx);

            request.setAttribute("pLesPays", lesPays);
            request.setAttribute("pLesEpreuves", lesEpreuves);
            getServletContext().getRequestDispatcher("/vues/site/ajouterSites.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = request.getRequestURI();

        if (url.equals("/la2028/ServletSite/ajouter")) {
            String nomSite = request.getParameter("nomSite");
            String villeSite = request.getParameter("villeSite");
            int idPays = Integer.parseInt(request.getParameter("idPays"));
            String[] idsEpreuves = request.getParameterValues("idsEpreuves");

            Site s = new Site();
            s.setNom(nomSite);
            s.setVille(villeSite);

            Pays p = new Pays();
            p.setId(idPays);
            s.setPays(p);

            ArrayList<epreuve> epreuvesLiees = new ArrayList<>();
            if (idsEpreuves != null) {
                for (String idEpreuveStr : idsEpreuves) {
                    epreuve e = new epreuve();
                    e.setId(Integer.parseInt(idEpreuveStr));
                    epreuvesLiees.add(e);
                }
            }
            s.setLesEpreuves(epreuvesLiees);

            DaoSite.addSite(cnx, s);
            response.sendRedirect(request.getContextPath() + "/ServletSite/lister");
        }
    }
}